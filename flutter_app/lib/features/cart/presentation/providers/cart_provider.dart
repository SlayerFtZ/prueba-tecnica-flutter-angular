import 'dart:async';

import 'package:flutter_app/features/cart/domain/domain.dart';
import 'package:flutter_app/features/cart/infrastructure/infrastructure.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/shared/provider/shared_preference_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) => CartRepositoryImpl(
    CartDatasourceImpl(ref.watch(sharedPreferencesProvider)),
  ),
);

class CartNotifier extends Notifier<Cart> {
  @override
  Cart build() => ref.watch(cartRepositoryProvider).load();
  void add(Product product, {int quantity = 1}) => addItem(
    CartItem(
      productId: product.id,
      title: product.title,
      price: product.price.toDouble(),
      thumbnail: product.thumbnail,
      quantity: quantity,
    ),
  );

  void addItem(CartItem item) {
    final exists = state.items.any((e) => e.productId == item.productId);
    _update(
      exists
          ? [
              for (final e in state.items)
                if (e.productId == item.productId)
                  e.copyWith(quantity: e.quantity + item.quantity)
                else
                  e,
            ]
          : [...state.items, item],
    );
  }

  void increment(int productId) {
    final current = _quantityOf(productId);
    if (current != null) setQuantity(productId, current + 1);
  }

  void decrement(int productId) {
    final current = _quantityOf(productId);
    if (current != null) setQuantity(productId, current - 1);
  }

  void setQuantity(int productId, int quantity) {
    if (quantity <= 0) return remove(productId);
    _update([
      for (final e in state.items)
        if (e.productId == productId) e.copyWith(quantity: quantity) else e,
    ]);
  }

  void remove(int productId) =>
      _update(state.items.where((e) => e.productId != productId).toList());

  void clear() => _update(const []);

  int? _quantityOf(int productId) {
    for (final e in state.items) {
      if (e.productId == productId) return e.quantity;
    }
    return null;
  }

  void _update(List<CartItem> items) {
    state = Cart(List.unmodifiable(items));
    unawaited(ref.read(cartRepositoryProvider).save(state));
  }
}

final cartProvider = NotifierProvider<CartNotifier, Cart>(CartNotifier.new);

final cartCountProvider = Provider<int>(
  (ref) => ref.watch(cartProvider.select((c) => c.itemCount)),
);

final cartTotalProvider = Provider<double>(
  (ref) => ref.watch(cartProvider.select((c) => c.total)),
);

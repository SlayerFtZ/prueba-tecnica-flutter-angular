import 'package:flutter/foundation.dart';

@immutable
class CartItem {
  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.quantity = 1,
  });

  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;

  double get subtotal => price * quantity;

  CartItem copyWith({int? quantity}) => CartItem(
    productId: productId,
    title: title,
    price: price,
    thumbnail: thumbnail,
    quantity: quantity ?? this.quantity,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          other.productId == productId &&
          other.title == title &&
          other.price == price &&
          other.thumbnail == thumbnail &&
          other.quantity == quantity;

  @override
  int get hashCode => Object.hash(productId, title, price, thumbnail, quantity);
}

@immutable
class Cart {
  const Cart([this.items = const []]);

  final List<CartItem> items;

  bool get isEmpty => items.isEmpty;
  int get itemCount => items.fold(0, (sum, e) => sum + e.quantity);

  double get total => items.fold(0, (sum, e) => sum + e.subtotal);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Cart && listEquals(other.items, items);

  @override
  int get hashCode => Object.hashAll(items);
}

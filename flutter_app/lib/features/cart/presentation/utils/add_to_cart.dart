import 'package:flutter/material.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AddToCartX on WidgetRef {
  void addToCart(BuildContext context, Product product, {int quantity = 1}) {
    read(cartProvider.notifier).add(product, quantity: quantity);

    final message = quantity == 1
        ? '${product.title} agregado al carrito'
        : '$quantity × ${product.title} agregados al carrito';

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(duration: const Duration(seconds: 2), content: Text(message)),
      );
  }
}

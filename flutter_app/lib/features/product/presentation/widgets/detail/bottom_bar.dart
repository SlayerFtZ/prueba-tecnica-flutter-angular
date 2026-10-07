// ─── Barra inferior con total y botón ─────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';
import 'package:flutter_app/features/cart/presentation/utils/add_to_cart.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_quantity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _pagePadding = 16.0;

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final inStock = product.stock > 0;
    final quantity = ref.watch(productQuantityProvider(product.id));
    final total = product.finalPrice * quantity;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(_pagePadding),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    PriceFormatter.format(total),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: inStock
                      ? () =>
                            ref.addToCart(context, product, quantity: quantity)
                      : null,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: Text(inStock ? 'Agregar al carrito' : 'No disponible'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

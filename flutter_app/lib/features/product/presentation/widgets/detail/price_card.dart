// ─── Precio, disponibilidad y cantidad ────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_badge.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      PriceFormatter.format(product.finalPrice),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                if (product.hasDiscount) ...[
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      PriceFormatter.format(product.price),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (product.hasDiscount) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  ProductBadge(
                    label: '-${product.discountPercentage.round()}%',
                    background: colors.error,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Ahorras ${PriceFormatter.format(product.savings)}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Cabecera ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_rating_row.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final brand = product.brand;
    final reviewsCount = product.reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.category.isNotEmpty)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Text(
                    product.category.replaceAll('-', ' '),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            if (brand != null && brand.isNotEmpty) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  brand.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ProductRatingRow(rating: product.rating),
            if (reviewsCount > 0) ...[
              const SizedBox(width: 8),
              Text(
                '($reviewsCount ${reviewsCount == 1 ? 'opinión' : 'opiniones'})',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

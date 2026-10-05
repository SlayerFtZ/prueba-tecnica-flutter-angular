import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_badge.dart';

class ProductDiscountRow extends StatelessWidget {
  const ProductDiscountRow({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Flexible(
          child: Text(
            PriceFormatter.format(product.price),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        const SizedBox(width: 6),
        ProductBadge(
          label: '-${product.discountPercentage.round()}%',
          background: theme.colorScheme.error,
        ),
      ],
    );
  }
}

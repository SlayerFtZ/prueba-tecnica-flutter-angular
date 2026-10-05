import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';

class ProductPriceColumn extends StatelessWidget {
  const ProductPriceColumn({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            PriceFormatter.format(product.finalPrice),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (product.hasDiscount)
          Text(
            'Ahorras ${PriceFormatter.format(product.savings)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

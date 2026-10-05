import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_add_button.dart';

import 'package:flutter_app/features/product/presentation/widgets/product_discount_row.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_image.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_price_column.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_rating_row.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  static const height = 140.0;

  static const _padding = 7.0;
  static const _imageWidth = 120.0;
  static const _discountRowHeight = 20.0;

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final inStock = product.stock > 0;

    return SizedBox(
      height: height,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: colors.outlineVariant),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: _imageWidth,
                  child: ProductImage(
                    url: product.thumbnail,
                    soldOut: !inStock,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          letterSpacing: 0.4,
                        ),
                      ),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ProductRatingRow(rating: product.rating),
                      const Spacer(),
                      SizedBox(
                        height: _discountRowHeight,
                        child: product.hasDiscount
                            ? ProductDiscountRow(product: product)
                            : null,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: ProductPriceColumn(product: product)),
                          ProductAddButton(
                            onPressed: inStock ? onAddToCart : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

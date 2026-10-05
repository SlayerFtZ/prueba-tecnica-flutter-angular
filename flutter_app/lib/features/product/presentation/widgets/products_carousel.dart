import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_card.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_skeleton_card.dart';

const _listPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
const _itemSpacing = 8.0;

class ProductsCarousel extends StatelessWidget {
  const ProductsCarousel({
    super.key,
    required this.products,
    required this.onProductTap,
    required this.onAddToCart,
  });

  final List<Product> products;
  final ValueChanged<Product> onProductTap;
  final ValueChanged<Product> onAddToCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ProductCard.height + _listPadding.vertical,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: _listPadding,
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(width: _itemSpacing),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () => onProductTap(product),
            onAddToCart: () => onAddToCart(product),
          );
        },
      ),
    );
  }
}

class ProductsCarouselPlaceholder extends StatelessWidget {
  const ProductsCarouselPlaceholder({super.key});

  static const _count = 3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ProductCard.height + _listPadding.vertical,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: _listPadding,
        itemCount: _count,
        separatorBuilder: (_, _) => const SizedBox(width: _itemSpacing),
        itemBuilder: (_, _) => const ProductCardSkeleton(),
      ),
    );
  }
}

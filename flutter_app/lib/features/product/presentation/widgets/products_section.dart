import 'package:flutter/material.dart';
import 'package:flutter_app/core/error/failure.dart';
import 'package:flutter_app/features/home/presentation/widgets/section_error.dart';
import 'package:flutter_app/features/product/presentation/providers/products_by_category_provider.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_carousel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsSection extends ConsumerWidget {
  const ProductsSection({
    super.key,
    required this.title,
    required this.categorySlug,
  });

  final String title;
  final String categorySlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsByCategoryProvider(categorySlug));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        products.when(
          loading: () => const ProductsCarouselPlaceholder(),
          error: (error, _) => SectionError(
            message: error is Failure
                ? error.message
                : 'Ocurrió un error inesperado.',
            onRetry: () =>
                ref.invalidate(productsByCategoryProvider(categorySlug)),
          ),
          data: (items) => items.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('No hay productos en esta categoría.'),
                )
              : ProductsCarousel(
                  products: items,
                  onProductTap: (product) {
                    // TODO: navegar al detalle (siguiente paso)
                  },
                  onAddToCart: (product) {
                    // TODO: agregar al carrito (paso del carrito)
                  },
                ),
        ),
      ],
    );
  }
}

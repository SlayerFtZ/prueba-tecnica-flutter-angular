import 'package:flutter/material.dart';
import 'package:flutter_app/core/error/failure.dart';
import 'package:flutter_app/features/home/presentation/widgets/section_error.dart';
import 'package:flutter_app/features/product/presentation/providers/categories_provider.dart';
import 'package:flutter_app/features/product/presentation/widgets/categories_carousel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Categorías',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        categories.when(
          loading: () => const CategoriesCarouselPlaceholder(),
          error: (error, _) => SectionError(
            message: error is Failure
                ? error.message
                : 'Ocurrió un error inesperado.',
            onRetry: () => ref.invalidate(categoriesProvider),
          ),
          data: (items) => items.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('No hay categorías disponibles.'),
                )
              : CategoriesCarousel(
                  categories: items,
                  onCategoryTap: (category) {
                    // TODO: navegar a los productos de la categoría
                  },
                ),
        ),
      ],
    );
  }
}

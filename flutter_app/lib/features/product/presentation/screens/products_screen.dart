import 'package:flutter/material.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/cart/presentation/widgets/cart_button.dart';
import 'package:flutter_app/features/product/presentation/providers/product_view_mode_provider.dart';
import 'package:flutter_app/features/product/presentation/providers/products_pagination_provider.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_results_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({
    super.key,
    required this.categorySlug,
    required this.title,
  });

  static const _addQuantity = 1;

  final String categorySlug;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = productsPaginationProvider(categorySlug);
    final state = ref.watch(provider);
    final isGrid = ref.watch(productViewModeProvider) == ProductViewMode.grid;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: isGrid ? 'Ver como lista' : 'Ver como grilla',
            icon: Icon(
              isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
            ),
            onPressed: () =>
                ref.read(productViewModeProvider.notifier).toggle(),
          ),
          const CartButton(),
        ],
      ),
      body: ProductsResultsView(
        state: state,
        isGrid: isGrid,
        onLoadMore: () => ref.read(provider.notifier).loadNextPage(),
        onRefresh: () => ref.read(provider.notifier).refresh(),
        onRetry: () => ref.read(provider.notifier).retry(),
        onProductTap: (product) =>
            context.push(AppRoutes.productPath(product.id)),
        onAddToCart: (product) => ref
            .read(cartProvider.notifier)
            .add(product, quantity: _addQuantity),
        emptyMessage: 'No hay productos en esta categoría.',
      ),
    );
  }
}

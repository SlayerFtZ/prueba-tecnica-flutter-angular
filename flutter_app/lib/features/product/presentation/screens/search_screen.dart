import 'package:flutter/material.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/cart/presentation/widgets/card_button.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/categories_provider.dart';
import 'package:flutter_app/features/product/presentation/providers/product_view_mode_provider.dart';
import 'package:flutter_app/features/product/presentation/providers/search_providers.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_results_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const double _categoryFilterHeight = 56;

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  static const _addQuantity = 1;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).clear();
  }

  void _onAddToCart(Product product) {
    ref.read(cartProvider.notifier).add(product, quantity: _addQuantity);
  }

  void _onProductTap(Product product) {
    FocusScope.of(context).unfocus();
    context.push(AppRoutes.productPath(product.id));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(searchQueryProvider, (_, next) {
      if (_controller.text != next) {
        _controller.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    });

    final query = ref.watch(searchQueryProvider);
    final category = ref.watch(searchCategoryProvider);
    final state = ref.watch(searchProductsProvider);
    final isGrid = ref.watch(productViewModeProvider) == ProductViewMode.grid;
    final isIdle = query.isEmpty && category == null;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).onChanged(value),
          onSubmitted: (value) =>
              ref.read(searchQueryProvider.notifier).submit(value),
          decoration: InputDecoration(
            hintText: 'Buscar productos…',
            border: InputBorder.none,
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (_, value, _) => value.text.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      tooltip: 'Borrar',
                      icon: const Icon(Icons.close_rounded),
                      onPressed: _clear,
                    ),
            ),
          ),
        ),
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(_categoryFilterHeight),
          child: _CategoryFilter(),
        ),
      ),
      body: isIdle
          ? const _IdleView()
          : ProductsResultsView(
              state: state,
              isGrid: isGrid,
              onLoadMore: () =>
                  ref.read(searchProductsProvider.notifier).loadNextPage(),
              onRefresh: () =>
                  ref.read(searchProductsProvider.notifier).refresh(),
              onRetry: () => ref.read(searchProductsProvider.notifier).retry(),
              onProductTap: _onProductTap,
              onAddToCart: _onAddToCart,
              emptyMessage: query.isEmpty
                  ? 'No hay productos en esta categoría.'
                  : 'No encontramos resultados para “$query”.',
            ),
    );
  }
}

class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selected = ref.watch(searchCategoryProvider);

    return SizedBox(
      height: _categoryFilterHeight,
      child: categories.when(
        loading: () => const SizedBox.shrink(),
        error: (_, _) => const SizedBox.shrink(),
        data: (items) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            final category = items[index];
            return FilterChip(
              label: Text(category.name),
              selected: category.slug == selected,
              onSelected: (_) => ref
                  .read(searchCategoryProvider.notifier)
                  .toggle(category.slug),
            );
          },
        ),
      ),
    );
  }
}

class _IdleView extends StatelessWidget {
  const _IdleView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, size: 56, color: color),
            const SizedBox(height: 12),
            Text(
              'Busca por nombre o elige una categoría',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

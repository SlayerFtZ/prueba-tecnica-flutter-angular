import 'package:flutter/material.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/categories_provider.dart';
import 'package:flutter_app/features/product/presentation/providers/product_view_mode_provider.dart';
import 'package:flutter_app/features/product/presentation/providers/search_providers.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_results_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
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

  void _onAddToCart(Product product) {}

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

    final queryNotifier = ref.read(searchQueryProvider.notifier);
    final resultsNotifier = ref.read(searchProductsProvider.notifier);
    final isIdle = query.isEmpty && category == null;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          onChanged: queryNotifier.onChanged,
          onSubmitted: queryNotifier.submit,
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
            onPressed: ref.read(productViewModeProvider.notifier).toggle,
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: _CategoryFilter(),
        ),
      ),
      body: isIdle
          ? const _IdleView()
          : ProductsResultsView(
              state: state,
              isGrid: isGrid,
              onLoadMore: resultsNotifier.loadNextPage,
              onRefresh: resultsNotifier.refresh,
              onRetry: resultsNotifier.retry,
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
    final notifier = ref.read(searchCategoryProvider.notifier);

    return SizedBox(
      height: 56,
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
              onSelected: (_) => notifier.toggle(category.slug),
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

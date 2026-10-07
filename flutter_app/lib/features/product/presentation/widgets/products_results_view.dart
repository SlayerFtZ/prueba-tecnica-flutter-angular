import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/presentation/widgets/section_error.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/products_pagination_provider.dart';
import 'package:flutter_app/features/product/presentation/widgets/pagination_footer.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_card.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_card_horizontal.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_skeleton_card.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_skeleton_horizontal.dart';
import 'package:flutter_app/features/shared/widgets/footer.dart';

const _pagePadding = EdgeInsets.fromLTRB(16, 12, 16, 12);
const _spacing = 12.0;
const _initialSkeletons = 6;
const _loadMoreSkeletons = 2;
const _loadMoreThreshold = 400.0;

class ProductsResultsView extends StatefulWidget {
  const ProductsResultsView({
    super.key,
    required this.state,
    required this.isGrid,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onRetry,
    required this.onProductTap,
    required this.onAddToCart,
    required this.emptyMessage,
  });

  final ProductsPaginationState state;
  final bool isGrid;
  final VoidCallback onLoadMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final ValueChanged<Product> onProductTap;
  final ValueChanged<Product> onAddToCart;
  final String emptyMessage;

  @override
  State<ProductsResultsView> createState() => _ProductsResultsViewState();
}

class _ProductsResultsViewState extends State<ProductsResultsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          ..._buildSlivers(),
          const SliverToBoxAdapter(child: AppFooter()),
        ],
      ),
    );
  }

  List<Widget> _buildSlivers() {
    final state = widget.state;
    final isGrid = widget.isGrid;

    if (state.isInitialLoading) {
      return [
        _itemsSliver(
          itemCount: _initialSkeletons,
          itemBuilder: (_) => _skeleton(),
        ),
      ];
    }

    if (state.hasInitialError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: SectionError(
              message: state.errorMessage!,
              onRetry: widget.onRetry,
            ),
          ),
        ),
      ];
    }

    if (state.items.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(widget.emptyMessage, textAlign: TextAlign.center),
            ),
          ),
        ),
      ];
    }

    final extra = state.isLoading ? _loadMoreSkeletons : 0;

    return [
      _itemsSliver(
        itemCount: state.items.length + extra,
        itemBuilder: (index) {
          if (index >= state.items.length) return _skeleton();
          final product = state.items[index];
          return isGrid
              ? ProductCard(
                  product: product,
                  onTap: () => widget.onProductTap(product),
                  onAddToCart: () => widget.onAddToCart(product),
                )
              : ProductCardHorizontal(
                  product: product,
                  onTap: () => widget.onProductTap(product),
                  onAddToCart: () => widget.onAddToCart(product),
                );
        },
      ),
      SliverToBoxAdapter(
        child: Footer(state: state, onRetry: widget.onRetry),
      ),
    ];
  }

  Widget _skeleton() => widget.isGrid
      ? const ProductCardSkeleton()
      : const ProductCardHorizontalSkeleton();

  Widget _itemsSliver({
    required int itemCount,
    required Widget Function(int index) itemBuilder,
  }) {
    return SliverPadding(
      padding: _pagePadding,
      sliver: widget.isGrid
          ? SliverGrid.builder(
              gridDelegate: _gridDelegate,
              itemCount: itemCount,
              itemBuilder: (_, index) => itemBuilder(index),
            )
          : SliverList.separated(
              itemCount: itemCount,
              separatorBuilder: (_, _) => const SizedBox(height: _spacing),
              itemBuilder: (_, index) => itemBuilder(index),
            ),
    );
  }

  static final _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 220,
    mainAxisExtent: ProductCard.height,
    mainAxisSpacing: _spacing,
    crossAxisSpacing: _spacing,
  );
}

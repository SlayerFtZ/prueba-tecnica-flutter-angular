import 'dart:async';

import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/core/error/failure.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';
import 'package:flutter_app/features/product/presentation/providers/products_pagination_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_providers.g.dart';

@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier {
  static const debounce = Duration(milliseconds: 400);

  Timer? _timer;

  @override
  String build() {
    ref.onDispose(() => _timer?.cancel());
    return '';
  }

  void onChanged(String raw) {
    _timer?.cancel();
    final query = raw.trim();
    if (query == state) return;
    _timer = Timer(debounce, () => state = query);
  }

  void submit(String raw) {
    _timer?.cancel();
    state = raw.trim();
  }

  void clear() {
    _timer?.cancel();
    state = '';
  }
}

@riverpod
class SearchCategoryNotifier extends _$SearchCategoryNotifier {
  @override
  String? build() => null;

  void toggle(String slug) => state = state == slug ? null : slug;
}

@riverpod
class SearchProductsNotifier extends _$SearchProductsNotifier {
  static const _noCriteriaMessage = 'No hay búsqueda ni categoría activa.';

  int _generation = 0;
  int _skip = 0;
  String _query = '';
  String? _category;

  bool get _filtersInClient => _query.isNotEmpty && _category != null;

  @override
  ProductsPaginationState build() {
    _query = ref.watch(searchQueryProvider);
    _category = ref.watch(searchCategoryProvider);
    _generation++;
    _skip = 0;

    if (_query.isEmpty && _category == null) {
      return const ProductsPaginationState();
    }

    final generation = _generation;
    Future.microtask(() => _fetch(generation, replace: true));
    return const ProductsPaginationState(isLoading: true);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading ||
        state.hasReachedEnd ||
        state.errorMessage != null ||
        state.items.isEmpty) {
      return;
    }
    await _fetch(_generation, replace: false);
  }

  Future<void> refresh() async {
    if (state.isLoading) return;
    if (_query.isEmpty && _category == null) return;
    await _fetch(_generation, replace: true);
  }

  Future<void> retry() async {
    if (state.isLoading) return;
    await _fetch(_generation, replace: state.items.isEmpty);
  }

  Future<ProductsPage> _request() async {
    final repository = ref.read(productsRepositoryProvider);
    final category = _category;

    if (_query.isNotEmpty) {
      return repository.searchProducts(
        _query,
        limit: Environment.pageSize,
        skip: _skip,
      );
    }
    if (category == null) {
      throw const UnknownFailure(_noCriteriaMessage);
    }
    return repository.getProductsByCategory(
      category,
      limit: Environment.pageSize,
      skip: _skip,
    );
  }

  bool _matches(Product product) =>
      !_filtersInClient || product.category == _category;

  Future<void> _fetch(int generation, {required bool replace}) async {
    if (!ref.mounted || generation != _generation) return;
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      if (replace) _skip = 0;
      var items = replace ? <Product>[] : [...state.items];
      final target = items.length + Environment.pageSize;
      var reachedEnd = false;

      do {
        final page = await _request();
        if (!ref.mounted || generation != _generation) return;

        _skip += page.products.length;
        items = [...items, ...page.products.where(_matches)];
        reachedEnd = page.products.isEmpty || _skip >= page.total;
      } while (_filtersInClient && !reachedEnd && items.length < target);

      state = state.copyWith(
        items: items,
        isLoading: false,
        hasReachedEnd: reachedEnd,
      );
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = state.copyWith(
        isLoading: false,
        errorMessage: error is Failure
            ? error.message
            : 'Ocurrió un error inesperado.',
      );
    }
  }
}

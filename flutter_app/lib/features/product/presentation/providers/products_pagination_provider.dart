import 'package:flutter/foundation.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/core/error/failure.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ProductsPaginationState {
  const ProductsPaginationState({
    this.items = const [],
    this.isLoading = false,
    this.hasReachedEnd = false,
    this.errorMessage,
  });

  final List<Product> items;
  final bool isLoading;
  final bool hasReachedEnd;
  final String? errorMessage;

  bool get isInitialLoading => isLoading && items.isEmpty;
  bool get hasInitialError => errorMessage != null && items.isEmpty;

  ProductsPaginationState copyWith({
    List<Product>? items,
    bool? isLoading,
    bool? hasReachedEnd,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProductsPaginationState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class ProductsPaginationNotifier extends Notifier<ProductsPaginationState> {
  ProductsPaginationNotifier(this.categorySlug);

  final String categorySlug;

  @override
  ProductsPaginationState build() {
    Future.microtask(() => _fetch(skip: 0, replace: true));
    return const ProductsPaginationState(isLoading: true);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading ||
        state.hasReachedEnd ||
        state.errorMessage != null ||
        state.items.isEmpty) {
      return;
    }
    await _fetch(skip: state.items.length, replace: false);
  }

  Future<void> refresh() async {
    if (state.isLoading) return;
    await _fetch(skip: 0, replace: true);
  }

  Future<void> retry() async {
    if (state.isLoading) return;
    if (state.items.isEmpty) {
      await _fetch(skip: 0, replace: true);
    } else {
      await _fetch(skip: state.items.length, replace: false);
    }
  }

  Future<void> _fetch({required int skip, required bool replace}) async {
    if (!ref.mounted) return;
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final page = await ref
          .read(productsRepositoryProvider)
          .getProductsByCategory(
            categorySlug,
            limit: Environment.pageSize,
            skip: skip,
          );
      if (!ref.mounted) return;

      final items = replace
          ? page.products
          : [...state.items, ...page.products];

      state = state.copyWith(
        items: items,
        isLoading: false,

        hasReachedEnd: page.products.isEmpty || items.length >= page.total,
      );
    } catch (error) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        errorMessage: error is Failure
            ? error.message
            : 'Ocurrió un error inesperado.',
      );
    }
  }
}

final productsPaginationProvider = NotifierProvider.autoDispose
    .family<ProductsPaginationNotifier, ProductsPaginationState, String>(
      ProductsPaginationNotifier.new,
    );

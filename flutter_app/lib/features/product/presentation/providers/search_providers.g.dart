// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQueryNotifier)
final searchQueryProvider = SearchQueryNotifierProvider._();

final class SearchQueryNotifierProvider
    extends $NotifierProvider<SearchQueryNotifier, String> {
  SearchQueryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryNotifierHash();

  @$internal
  @override
  SearchQueryNotifier create() => SearchQueryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryNotifierHash() =>
    r'f7fcbf7a1367a2b43d5109922461f92d17a806cf';

abstract class _$SearchQueryNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchCategoryNotifier)
final searchCategoryProvider = SearchCategoryNotifierProvider._();

final class SearchCategoryNotifierProvider
    extends $NotifierProvider<SearchCategoryNotifier, String?> {
  SearchCategoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchCategoryNotifierHash();

  @$internal
  @override
  SearchCategoryNotifier create() => SearchCategoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$searchCategoryNotifierHash() =>
    r'e4b7add3ce95fa41e54a5c7f98a9c85b4eff4fd4';

abstract class _$SearchCategoryNotifier extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchProductsNotifier)
final searchProductsProvider = SearchProductsNotifierProvider._();

final class SearchProductsNotifierProvider
    extends $NotifierProvider<SearchProductsNotifier, ProductsPaginationState> {
  SearchProductsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchProductsNotifierHash();

  @$internal
  @override
  SearchProductsNotifier create() => SearchProductsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductsPaginationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductsPaginationState>(value),
    );
  }
}

String _$searchProductsNotifierHash() =>
    r'3c653ff429a607d7d8ac0d858f9a69b0e3d80ba5';

abstract class _$SearchProductsNotifier
    extends $Notifier<ProductsPaginationState> {
  ProductsPaginationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ProductsPaginationState, ProductsPaginationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProductsPaginationState, ProductsPaginationState>,
              ProductsPaginationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

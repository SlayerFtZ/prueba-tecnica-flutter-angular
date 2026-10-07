// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_quantity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductQuantityNotifier)
final productQuantityProvider = ProductQuantityNotifierFamily._();

final class ProductQuantityNotifierProvider
    extends $NotifierProvider<ProductQuantityNotifier, int> {
  ProductQuantityNotifierProvider._({
    required ProductQuantityNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productQuantityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productQuantityNotifierHash();

  @override
  String toString() {
    return r'productQuantityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductQuantityNotifier create() => ProductQuantityNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductQuantityNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productQuantityNotifierHash() =>
    r'ee9eebdaa167460dde3152681732f4acbda6612b';

final class ProductQuantityNotifierFamily extends $Family
    with $ClassFamilyOverride<ProductQuantityNotifier, int, int, int, int> {
  ProductQuantityNotifierFamily._()
    : super(
        retry: null,
        name: r'productQuantityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductQuantityNotifierProvider call(int productId) =>
      ProductQuantityNotifierProvider._(argument: productId, from: this);

  @override
  String toString() => r'productQuantityProvider';
}

abstract class _$ProductQuantityNotifier extends $Notifier<int> {
  late final _$args = ref.$arg as int;
  int get productId => _$args;

  int build(int productId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

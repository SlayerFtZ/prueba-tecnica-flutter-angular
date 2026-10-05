import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _sectionLimit = 10;

final productsByCategoryProvider = FutureProvider.family<List<Product>, String>(
  (ref, slug) async {
    final page = await ref
        .watch(productsRepositoryProvider)
        .getProductsByCategory(slug, limit: _sectionLimit);
    return page.products;
  },

  retry: (retryCount, error) => null,
);

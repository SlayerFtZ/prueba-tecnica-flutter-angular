import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.watch(productsRepositoryProvider).getCategories(),

  retry: (retryCount, error) => null,
);

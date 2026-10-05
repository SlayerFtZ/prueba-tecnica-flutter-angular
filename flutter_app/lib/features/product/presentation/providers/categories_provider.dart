import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.watch(productsRepositoryProvider).getCategories(),
  // Riverpod 3 reintenta solo; lo desactivamos para mostrar el error
  // de inmediato y que el reintento sea manual (botón).
  retry: (retryCount, error) => null,
);

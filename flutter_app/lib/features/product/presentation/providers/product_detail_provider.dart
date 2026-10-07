import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailProvider = FutureProvider.autoDispose.family<Product, int>((
  ref,
  id,
) {
  return ref.watch(productsRepositoryProvider).getProductById(id);
});

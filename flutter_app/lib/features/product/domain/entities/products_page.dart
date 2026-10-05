import 'package:flutter/foundation.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';

@immutable
class ProductsPage {
  const ProductsPage({
    required this.products,
    required this.total,
    required this.skip,
  });

  final List<Product> products;
  final int total;
  final int skip;

  bool get hasMore => skip + products.length < total;
}

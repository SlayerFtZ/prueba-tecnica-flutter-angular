import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';

abstract interface class ProductsDatasource {
  Future<ProductsPage> getProducts({required int limit, required int skip});
  Future<ProductsPage> searchProducts(
    String query, {
    required int limit,
    required int skip,
  });
  Future<Product> getProductById(int id);
  Future<List<Category>> getCategories();
  Future<ProductsPage> getProductsByCategory(
    String slug, {
    required int limit,
    required int skip,
  });
}

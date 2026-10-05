import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';

abstract interface class ProductsRepository {
  Future<ProductsPage> getProducts({
    int limit = Environment.pageSize,
    int skip = 0,
  });
  Future<ProductsPage> searchProducts(
    String query, {
    int limit = Environment.pageSize,
    int skip = 0,
  });
  Future<Product> getProductById(int id);
  Future<List<Category>> getCategories();
  Future<ProductsPage> getProductsByCategory(
    String slug, {
    int limit = Environment.pageSize,
    int skip = 0,
  });
}

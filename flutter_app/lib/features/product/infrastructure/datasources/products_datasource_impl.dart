import 'package:dio/dio.dart';
import 'package:flutter_app/features/product/domain/datasources/products_datasource.dart';
import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';
import 'package:flutter_app/features/product/infrastructure/mappers/category_mapper.dart';
import 'package:flutter_app/features/product/infrastructure/mappers/product_mapper.dart';
import 'package:flutter_app/features/product/infrastructure/models/category_model.dart';
import 'package:flutter_app/features/product/infrastructure/models/product_model.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  const ProductsDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ProductsPage> getProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/products',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return _toPage(_bodyOf(response));
  }

  @override
  Future<ProductsPage> searchProducts(
    String query, {
    required int limit,
    required int skip,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/products/search',
      queryParameters: {'q': query, 'limit': limit, 'skip': skip},
    );
    return _toPage(_bodyOf(response));
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/products/$id');
    return ProductMapper.toEntity(ProductModel.fromJson(_bodyOf(response)));
  }

  @override
  Future<List<Category>> getCategories() async {
    final response = await _dio.get<List<dynamic>>('/products/categories');
    return List.unmodifiable(
      _bodyOf(response).map(
        (e) => CategoryMapper.toEntity(
          CategoryModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  Future<ProductsPage> getProductsByCategory(
    String slug, {
    required int limit,
    required int skip,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/products/category/$slug',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return _toPage(_bodyOf(response));
  }

  T _bodyOf<T>(Response<T> response) {
    final data = response.data;
    if (data == null) {
      throw const FormatException('Respuesta vacía del servidor.');
    }
    return data;
  }

  ProductsPage _toPage(Map<String, dynamic> json) {
    final items = (json['products'] as List<dynamic>)
        .map(
          (e) => ProductMapper.toEntity(
            ProductModel.fromJson(e as Map<String, dynamic>),
          ),
        )
        .toList();
    return ProductsPage(
      products: List.unmodifiable(items),
      total: json['total'] as int,
      skip: json['skip'] as int,
    );
  }
}

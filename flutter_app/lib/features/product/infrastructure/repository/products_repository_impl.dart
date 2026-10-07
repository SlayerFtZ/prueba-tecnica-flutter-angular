import 'package:dio/dio.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/core/error/failure.dart';
import 'package:flutter_app/features/product/domain/datasources/products_datasource.dart';
import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';
import 'package:flutter_app/features/product/domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl(this._datasource);

  static const _notFoundStatus = 404;
  static const _unexpectedFormatMessage = 'Respuesta con formato inesperado.';

  final ProductsDatasource _datasource;

  @override
  Future<ProductsPage> getProducts({
    int limit = Environment.pageSize,
    int skip = 0,
  }) {
    return _guard(() => _datasource.getProducts(limit: limit, skip: skip));
  }

  @override
  Future<ProductsPage> searchProducts(
    String query, {
    int limit = Environment.pageSize,
    int skip = 0,
  }) {
    return _guard(
      () => _datasource.searchProducts(query, limit: limit, skip: skip),
    );
  }

  @override
  Future<Product> getProductById(int id) {
    return _guard(() => _datasource.getProductById(id));
  }

  @override
  Future<List<Category>> getCategories() {
    return _guard(_datasource.getCategories);
  }

  @override
  Future<ProductsPage> getProductsByCategory(
    String slug, {
    int limit = Environment.pageSize,
    int skip = 0,
  }) {
    return _guard(
      () => _datasource.getProductsByCategory(slug, limit: limit, skip: skip),
    );
  }

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _mapError(e);
    } on TypeError {
      throw const UnknownFailure(_unexpectedFormatMessage);
    } on FormatException {
      throw const UnknownFailure(_unexpectedFormatMessage);
    }
  }

  Failure _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        return e.response?.statusCode == _notFoundStatus
            ? const NotFoundFailure()
            : const ServerFailure();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }
}

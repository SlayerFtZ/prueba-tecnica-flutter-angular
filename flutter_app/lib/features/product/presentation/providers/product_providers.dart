import 'package:dio/dio.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/features/product/domain/datasources/products_datasource.dart';
import 'package:flutter_app/features/product/domain/repository/products_repository.dart';
import 'package:flutter_app/features/product/infrastructure/datasources/products_datasource_impl.dart';
import 'package:flutter_app/features/product/infrastructure/repository/products_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: Environment.baseApiUrl,
      connectTimeout: Environment.connectTimeout,
      receiveTimeout: Environment.receiveTimeout,
    ),
  );
});

final productsDatasourceProvider = Provider<ProductsDatasource>((ref) {
  return ProductsDatasourceImpl(ref.watch(dioProvider));
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(ref.watch(productsDatasourceProvider));
});

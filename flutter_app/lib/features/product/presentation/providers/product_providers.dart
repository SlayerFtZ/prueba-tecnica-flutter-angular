import 'package:dio/dio.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/features/product/domain/datasources/products_datasource.dart';
import 'package:flutter_app/features/product/domain/repository/products_repository.dart';
import 'package:flutter_app/features/product/infrastructure/datasources/products_datasource_impl.dart';
import 'package:flutter_app/features/product/infrastructure/repository/products_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: Environment.baseApiUrl,
      connectTimeout: Environment.connectTimeout,
      receiveTimeout: Environment.receiveTimeout,
    ),
  );
}

@Riverpod(keepAlive: true)
ProductsDatasource productsDatasource(Ref ref) {
  return ProductsDatasourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepositoryImpl(ref.watch(productsDatasourceProvider));
}

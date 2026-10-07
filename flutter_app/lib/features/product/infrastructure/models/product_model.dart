import 'package:flutter/foundation.dart';
import 'package:flutter_app/features/product/domain/entities/product_dimensions.dart';
import 'package:flutter_app/features/product/domain/entities/product_review.dart';

@immutable
class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.images,
    this.brand,
    this.tags = const [],
    this.sku = '',
    this.weight = 0,
    this.dimensions,
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.returnPolicy = '',
    this.minimumOrderQuantity = 1,
    this.reviews = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
      brand: json['brand'] as String?,
      thumbnail: json['thumbnail'] as String? ?? '',
      images: (json['images'] as List<dynamic>? ?? const [])
          .map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>? ?? const [])
          .map((e) => e as String)
          .toList(),
      sku: json['sku'] as String? ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      dimensions: json['dimensions'] is Map<String, dynamic>
          ? ProductDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>,
            )
          : null,
      warrantyInformation: json['warrantyInformation'] as String? ?? '',
      shippingInformation: json['shippingInformation'] as String? ?? '',
      returnPolicy: json['returnPolicy'] as String? ?? '',
      minimumOrderQuantity:
          (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
      reviews: (json['reviews'] as List<dynamic>? ?? const [])
          .map((e) => ProductReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final String thumbnail;
  final List<String> images;
  final List<String> tags;
  final String sku;
  final double weight;
  final ProductDimensions? dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<ProductReview> reviews;
}

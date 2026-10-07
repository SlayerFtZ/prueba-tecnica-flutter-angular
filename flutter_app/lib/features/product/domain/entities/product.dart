import 'package:flutter/foundation.dart';
import 'package:flutter_app/features/product/domain/entities/product_dimensions.dart';
import 'package:flutter_app/features/product/domain/entities/product_review.dart';

@immutable
class Product {
  const Product({
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Product && other.id == id);

  @override
  int get hashCode => id.hashCode;

  bool get hasDiscount => discountPercentage > 0;

  double get finalPrice => price * (1 - discountPercentage / 100);

  double get savings => price - finalPrice;
}

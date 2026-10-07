import 'package:flutter/foundation.dart';

@immutable
class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    productId: json['productId'] as int,
    title: json['title'] as String,
    price: (json['price'] as num).toDouble(),
    thumbnail: json['thumbnail'] as String,
    quantity: json['quantity'] as int,
  );

  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'price': price,
    'thumbnail': thumbnail,
    'quantity': quantity,
  };
}

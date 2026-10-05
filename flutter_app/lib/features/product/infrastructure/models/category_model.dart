import 'package:flutter/foundation.dart';

@immutable
class CategoryModel {
  const CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] as String,
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
    );
  }

  final String slug;
  final String name;
  final String url;
}

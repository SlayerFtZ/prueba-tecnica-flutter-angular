import 'package:flutter/foundation.dart';

@immutable
class Category {
  const Category({required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Category && other.slug == slug);

  @override
  int get hashCode => slug.hashCode;
}

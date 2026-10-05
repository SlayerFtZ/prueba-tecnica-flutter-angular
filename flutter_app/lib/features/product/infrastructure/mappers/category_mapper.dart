import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/infrastructure/models/category_model.dart';

abstract final class CategoryMapper {
  static Category toEntity(CategoryModel model) {
    return Category(slug: model.slug, name: model.name);
  }
}

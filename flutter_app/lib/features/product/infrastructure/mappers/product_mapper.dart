import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/infrastructure/models/product_model.dart';

abstract final class ProductMapper {
  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      price: model.price,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      stock: model.stock,
      brand: model.brand,
      thumbnail: model.thumbnail,
      images: List.unmodifiable(model.images),
    );
  }
}

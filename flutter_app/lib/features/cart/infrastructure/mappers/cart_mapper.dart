import 'package:flutter_app/features/cart/domain/domain.dart';
import 'package:flutter_app/features/cart/infrastructure/models/cart_model.dart';

abstract final class CartMapper {
  static CartItem itemToEntity(CartItemModel model) => CartItem(
    productId: model.productId,
    title: model.title,
    price: model.price,
    thumbnail: model.thumbnail,
    quantity: model.quantity,
  );

  static CartItemModel itemToModel(CartItem item) => CartItemModel(
    productId: item.productId,
    title: item.title,
    price: item.price,
    thumbnail: item.thumbnail,
    quantity: item.quantity,
  );
}

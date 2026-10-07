import 'package:flutter_app/features/cart/domain/entities/cart.dart';

abstract interface class CartDatasource {
  Cart load();
  Future<void> save(Cart cart);
}

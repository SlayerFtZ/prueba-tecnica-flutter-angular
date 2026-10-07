import 'package:flutter_app/features/cart/domain/entities/cart.dart';

abstract interface class CartRepository {
  Cart load();
  Future<void> save(Cart cart);
}

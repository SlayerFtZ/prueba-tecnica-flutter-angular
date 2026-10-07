import 'package:flutter_app/features/cart/domain/domain.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._datasource);

  final CartDatasource _datasource;

  @override
  Cart load() => _datasource.load();

  @override
  Future<void> save(Cart cart) => _datasource.save(cart);
}

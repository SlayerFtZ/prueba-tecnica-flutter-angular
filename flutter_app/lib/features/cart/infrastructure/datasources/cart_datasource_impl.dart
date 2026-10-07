import 'dart:convert';

import 'package:flutter_app/features/cart/domain/domain.dart';
import 'package:flutter_app/features/cart/infrastructure/mappers/cart_mapper.dart';
import 'package:flutter_app/features/cart/infrastructure/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartDatasourceImpl implements CartDatasource {
  CartDatasourceImpl(this._prefs);

  static const _key = 'cart_items_v1';

  final SharedPreferences _prefs;

  @override
  Cart load() {
    final raw = _prefs.getString(_key);
    if (raw == null) return const Cart();

    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return Cart(
        List.unmodifiable(
          list.map(
            (e) => CartMapper.itemToEntity(
              CartItemModel.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
      );
    } on FormatException {
      return const Cart();
    } on TypeError {
      return const Cart();
    }
  }

  @override
  Future<void> save(Cart cart) => _prefs.setString(
    _key,
    jsonEncode(
      cart.items.map((e) => CartMapper.itemToModel(e).toJson()).toList(),
    ),
  );
}

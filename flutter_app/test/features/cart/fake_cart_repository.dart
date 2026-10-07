import 'package:flutter_app/features/cart/domain/domain.dart';

/// Repositorio falso del carrito, en memoria.
///
/// Reemplaza al repositorio real (shared_preferences) en las pruebas, para que
/// no dependan del disco ni de plugins. Se inyecta con:
/// `cartRepositoryProvider.overrideWithValue(FakeCartRepository(...))`.
///
/// Sirve para dos cosas:
/// - Sembrar datos iniciales: lo que se pasa al constructor es lo que
///   `load()` devuelve (simula un carrito ya guardado).
/// - Verificar lo guardado: tras cada cambio, [saved] contiene el último
///   estado que la app pidió persistir.
class FakeCartRepository implements CartRepository {
  /// [initial] son las líneas con las que arranca el "disco" falso.
  FakeCartRepository([List<CartItem> initial = const []])
    : saved = Cart(initial);

  /// Último carrito guardado; las pruebas lo leen para comprobar persistencia.
  Cart saved;

  /// Devuelve lo que haya en memoria (equivale a leer del almacenamiento).
  @override
  Cart load() => saved;

  /// Guarda el carrito en memoria (equivale a escribir en el almacenamiento).
  @override
  Future<void> save(Cart cart) async {
    saved = cart;
  }
}

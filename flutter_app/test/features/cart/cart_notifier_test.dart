import 'package:flutter_app/features/cart/domain/domain.dart';
import 'package:flutter_app/features/cart/infrastructure/infrastructure.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_cart_repository.dart';

/// Crea una línea de carrito de prueba con datos fijos.
CartItem _item(int id, double price, {int quantity = 1}) => CartItem(
  productId: id,
  title: 'Producto $id',
  price: price,
  thumbnail: 'https://example.com/$id.jpg',
  quantity: quantity,
);

/// Crea un ProviderContainer que usa el repositorio falso (en memoria)
/// en lugar de shared_preferences, y lo libera al terminar cada prueba.
ProviderContainer _container(FakeCartRepository repo) {
  final container = ProviderContainer(
    overrides: [cartRepositoryProvider.overrideWithValue(repo)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  // Verifica que agregar un producto que ya está en el carrito NO crea
  // una segunda línea, sino que suma la cantidad a la existente.
  test('agregar el mismo producto dos veces suma la cantidad', () {
    final container = _container(FakeCartRepository());
    final notifier = container.read(cartProvider.notifier);

    notifier
      ..addItem(_item(1, 10))
      ..addItem(_item(1, 10));

    final items = container.read(cartProvider).items;
    expect(items, hasLength(1));
    expect(items.single.quantity, 2);
  });

  // Verifica el cambio de cantidad con los botones + y −, y que al bajar
  // de 1 a 0 la línea desaparece del carrito.
  test('increment, decrement y quitar al llegar a cero', () {
    final container = _container(FakeCartRepository([_item(1, 10)]));
    final notifier = container.read(cartProvider.notifier);

    notifier.increment(1);
    expect(container.read(cartProvider).items.single.quantity, 2);

    notifier.decrement(1);
    expect(container.read(cartProvider).items.single.quantity, 1);

    notifier.decrement(1); // llega a 0 → se elimina
    expect(container.read(cartProvider).items, isEmpty);
  });

  // Verifica los providers derivados: el contador (badge) suma unidades
  // y el total suma precio × cantidad de todas las líneas.
  // 2 × 10.0 + 1 × 5.5 = 25.5 en 3 unidades.
  test('total y contador suman todas las líneas', () {
    final container = _container(
      FakeCartRepository([_item(1, 10, quantity: 2), _item(2, 5.5)]),
    );

    expect(container.read(cartCountProvider), 3);
    expect(container.read(cartTotalProvider), closeTo(25.5, 0.001));
  });

  // Verifica que remove() quita solo la línea indicada (la otra se queda)
  // y que clear() deja el carrito completamente vacío.
  test('remove y clear vacían el carrito', () {
    final container = _container(
      FakeCartRepository([_item(1, 10), _item(2, 20)]),
    );
    final notifier = container.read(cartProvider.notifier);

    notifier.remove(1);
    expect(container.read(cartProvider).items.map((e) => e.productId), [2]);

    notifier.clear();
    expect(container.read(cartProvider).isEmpty, isTrue);
  });

  // Verifica la persistencia: tras modificar el carrito, el repositorio
  // recibe el estado nuevo (así sobrevive al cerrar la app).
  test('cada cambio se persiste en el repositorio', () {
    final repo = FakeCartRepository();
    final container = _container(repo);

    container.read(cartProvider.notifier).addItem(_item(7, 3));

    expect(repo.saved.items.single.productId, 7);
  });

  // Verifica la restauración: si el repositorio ya tenía datos guardados,
  // el carrito arranca con ellos (simula reabrir la app).
  test('el estado inicial se restaura desde el repositorio', () {
    final container = _container(
      FakeCartRepository([_item(3, 9, quantity: 4)]),
    );

    expect(container.read(cartProvider).items.single.quantity, 4);
  });

  // Verifica la capa de infraestructura: convertir entidad → modelo → JSON
  // y volver a entidad no pierde ni altera ningún dato.
  test('modelo y mapper: entidad → JSON → entidad conserva los datos', () {
    final original = _item(5, 12.5, quantity: 3);

    final json = CartMapper.itemToModel(original).toJson();
    final restored = CartMapper.itemToEntity(CartItemModel.fromJson(json));

    expect(restored, original);
  });
}

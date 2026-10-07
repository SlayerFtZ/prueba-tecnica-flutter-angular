import 'package:flutter/material.dart';
import 'package:flutter_app/features/cart/domain/domain.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_cart_repository.dart';

/// Monta CartScreen dentro de un MaterialApp, con el repositorio falso
/// (en memoria) en lugar de shared_preferences.
Widget _app(FakeCartRepository repo) => ProviderScope(
  overrides: [cartRepositoryProvider.overrideWithValue(repo)],
  child: const MaterialApp(home: CartScreen()),
);

void main() {
  // Verifica el flujo principal de la pantalla con un producto en el carrito:
  // 1) se muestran el título, el contador y el precio;
  // 2) al tocar "+" la cantidad sube a 2, el total pasa de $10.00 a $20.00
  //    y el cambio queda guardado en el repositorio (persistencia).
  testWidgets('muestra el producto y actualiza el total al aumentar', (
    tester,
  ) async {
    final repo = FakeCartRepository([
      const CartItem(
        productId: 1,
        title: 'iPhone',
        price: 10,
        thumbnail: 'https://example.com/i.jpg',
      ),
    ]);

    await tester.pumpWidget(_app(repo));

    // Estado inicial: 1 producto de $10.00.
    expect(find.text('iPhone'), findsOneWidget);
    expect(find.text('1 artículo'), findsOneWidget);
    expect(find.text(r'$10.00'), findsWidgets);

    // Acción: tocar el botón "+" de la tarjeta.
    await tester.tap(find.byTooltip('Aumentar'));
    await tester.pump();

    // Resultado: 2 unidades, total $20.00 y repositorio actualizado.
    expect(find.text('2 artículos'), findsOneWidget);
    expect(find.text(r'$20.00'), findsWidgets);
    expect(repo.saved.items.single.quantity, 2);
  });

  // Verifica el estado vacío: con el carrito sin productos se muestra el
  // mensaje "Tu carrito está vacío" y el botón "Agregar" para ir a buscar.
  testWidgets('muestra el estado vacío cuando no hay productos', (
    tester,
  ) async {
    await tester.pumpWidget(_app(FakeCartRepository()));

    expect(find.text('Tu carrito está vacío'), findsOneWidget);
    expect(find.text('Agregar'), findsOneWidget);
  });
}

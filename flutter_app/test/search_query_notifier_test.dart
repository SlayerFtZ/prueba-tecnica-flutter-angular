import 'package:fake_async/fake_async.dart';
import 'package:flutter_app/features/product/presentation/providers/search_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Verifica el debounce de la búsqueda (requisito 2 de la rúbrica):
  // si el usuario escribe varias letras seguidas, NO se publica una consulta
  // por cada tecla; solo se publica el último valor, 400 ms después de la
  // última pulsación.
  //
  // Se usa `fakeAsync` para controlar el reloj: así la prueba no espera
  // 400 ms reales y es exacta (399 ms vs 400 ms).
  test('debounce de 400 ms: solo se publica el último valor', () {
    fakeAsync((async) {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      // Mantiene vivo el provider autoDispose durante la prueba.
      container.listen(searchQueryProvider, (_, _) {});

      // El usuario teclea "p" → "ph" → "phone" sin pausa.
      final notifier = container.read(searchQueryProvider.notifier)
        ..onChanged('p')
        ..onChanged('ph')
        ..onChanged('phone');

      // A los 399 ms todavía no se publicó nada: la consulta sigue vacía.
      async.elapse(const Duration(milliseconds: 399));
      expect(container.read(searchQueryProvider), '');

      // Al cumplirse los 400 ms se publica solo el último valor ("phone"),
      // sin pasar por "p" ni "ph".
      async.elapse(const Duration(milliseconds: 1));
      expect(container.read(searchQueryProvider), 'phone');

      // clear() restablece la consulta a vacío de inmediato (botón "borrar").
      notifier.clear();
      expect(container.read(searchQueryProvider), '');
    });
  });
}

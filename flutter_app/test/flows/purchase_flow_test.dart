import 'package:flutter/material.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/domain/entities/products_page.dart';
import 'package:flutter_app/features/product/domain/repository/products_repository.dart';
import 'package:flutter_app/features/product/presentation/providers/product_providers.dart';
import 'package:flutter_app/features/shared/provider/shared_preference_provider.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _shirt = Product(
  id: 1,
  title: 'Camisa azul',
  description: 'Camisa de algodón',
  category: 'tops',
  price: 100,
  discountPercentage: 0,
  rating: 4.5,
  stock: 10,
  thumbnail: '',
  images: [],
);

const _pants = Product(
  id: 2,
  title: 'Pantalón negro',
  description: 'Pantalón de vestir',
  category: 'bottoms',
  price: 200,
  discountPercentage: 0,
  rating: 4.0,
  stock: 5,
  thumbnail: '',
  images: [],
);

const _catalog = [_shirt, _pants];

class FakeProductsRepository implements ProductsRepository {
  ProductsPage _page(List<Product> items) =>
      ProductsPage(products: items, total: items.length, skip: 0);

  @override
  Future<ProductsPage> getProducts({
    int limit = Environment.pageSize,
    int skip = 0,
  }) async => _page(skip == 0 ? _catalog : const []);

  @override
  Future<ProductsPage> searchProducts(
    String query, {
    int limit = Environment.pageSize,
    int skip = 0,
  }) async {
    if (skip > 0) return _page(const []);
    final q = query.toLowerCase();
    return _page(
      _catalog.where((p) => p.title.toLowerCase().contains(q)).toList(),
    );
  }

  @override
  Future<Product> getProductById(int id) async =>
      _catalog.firstWhere((p) => p.id == id);

  @override
  Future<List<Category>> getCategories() async => const [
    Category(slug: 'tops', name: 'Tops'),
    Category(slug: 'bottoms', name: 'Bottoms'),
  ];

  @override
  Future<ProductsPage> getProductsByCategory(
    String slug, {
    int limit = Environment.pageSize,
    int skip = 0,
  }) async {
    if (skip > 0) return _page(const []);
    return _page(_catalog.where((p) => p.category == slug).toList());
  }
}

/// pumpAndSettle puede colgarse con animaciones infinitas (skeletons),
/// así que avanzamos el reloj en pasos controlados.
Future<void> pumpFor(WidgetTester tester, Duration total) async {
  const step = Duration(milliseconds: 100);
  var elapsed = Duration.zero;
  while (elapsed < total) {
    await tester.pump(step);
    elapsed += step;
  }
}

void main() {
  testWidgets('flujo: buscar → ver detalle → agregar al carrito', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          productsRepositoryProvider.overrideWithValue(
            FakeProductsRepository(),
          ),
        ],
        child: const MainApp(),
      ),
    );
    await pumpFor(tester, const Duration(seconds: 1));

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MainApp)),
    );

    // 0. Ir a la pantalla de búsqueda
    container.read(routerProvider).go(AppRoutes.search);
    await pumpFor(tester, const Duration(milliseconds: 500));

    // 1. Buscar (el notifier tiene debounce de 400 ms)
    await tester.enterText(find.byType(TextField), 'camisa');
    await pumpFor(tester, const Duration(milliseconds: 800));

    expect(find.text('Camisa azul'), findsOneWidget);
    expect(find.text('Pantalón negro'), findsNothing);

    // 2. Ver detalle
    await tester.tap(find.text('Camisa azul'));
    await pumpFor(tester, const Duration(seconds: 1));

    expect(find.text('Detalle'), findsOneWidget);
    expect(find.text('Agregar al carrito'), findsOneWidget);

    // 3. Agregar al carrito
    expect(container.read(cartProvider).items, isEmpty);
    await tester.tap(find.text('Agregar al carrito'));
    await pumpFor(tester, const Duration(milliseconds: 500));

    // 4. Verificar estado y feedback visual
    final items = container.read(cartProvider).items;
    expect(items.length, 1);
    expect(items.first.productId, 1);
    expect(items.first.quantity, 1);
    expect(find.text('Camisa azul agregado al carrito'), findsOneWidget);

    // Dejar expirar el SnackBar para no dejar timers pendientes
    await pumpFor(tester, const Duration(seconds: 3));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app/features/product/presentation/screens/detail_product_screen.dart';
import 'package:flutter_app/features/product/presentation/screens/products_screen.dart';
import 'package:flutter_app/features/product/presentation/screens/search_screen.dart';
import 'package:flutter_app/features/shared/widgets/bottom_menu_bar.dart';
import 'package:flutter_app/features/shared/widgets/theme_menu_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

abstract final class AppRoutes {
  static const home = '/';
  static const search = '/search';
  static const cart = '/cart';
  static const category = '/category';
  static const product = '/product';

  static String categoryPath(String slug, String title) => Uri(
    path: '$category/$slug',
    queryParameters: {'title': title},
  ).toString();

  static String productPath(int id) => '$product/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) =>
            MenuShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen()),
          GoRoute(
            path: AppRoutes.search,
            builder: (_, _) => const SearchScreen(),
          ),
          GoRoute(path: AppRoutes.cart, builder: (_, _) => const CartScreen()),
          GoRoute(
            path: '${AppRoutes.category}/:slug',
            builder: (_, state) => ProductsScreen(
              categorySlug: state.pathParameters['slug'] ?? '',
              title: state.uri.queryParameters['title'] ?? '',
            ),
          ),
        ],
      ),
      GoRoute(
        path: '${AppRoutes.product}/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          if (id == null) {
            return RouteNotFoundScreen(location: state.uri.toString());
          }
          return ProductDetailScreen(productId: id);
        },
      ),
    ],
    errorBuilder: (_, state) =>
        RouteNotFoundScreen(location: state.uri.toString()),
  );
});

class MenuShell extends ConsumerWidget {
  const MenuShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  int get _currentIndex {
    if (location.startsWith(AppRoutes.search)) return BottomMenuIndex.search;
    if (location.startsWith(AppRoutes.cart)) return BottomMenuIndex.cart;
    return BottomMenuIndex.home;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case BottomMenuIndex.menu:
        showThemeMenuSheet(context);
      case BottomMenuIndex.search:
        context.go(AppRoutes.search);
      case BottomMenuIndex.cart:
        context.go(AppRoutes.cart);
      default:
        context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomMenuBar(
        currentIndex: _currentIndex,
        cartCount: ref.watch(cartCountProvider),
        onDestinationSelected: (i) => _onDestinationSelected(context, i),
      ),
    );
  }
}

class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ups')),
      body: Center(child: Text('Ruta no encontrada: $location')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/presentation/widgets/categories_section.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_section.dart';
import 'package:flutter_app/features/shared/widgets/bottom_menu_bar.dart';
import 'package:flutter_app/features/shared/widgets/footer.dart';
import 'package:flutter_app/features/shared/widgets/theme_menu_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _sections = <({String slug, String title})>[
    (slug: 'smartphones', title: 'Smartphones'),
    (slug: 'laptops', title: 'Laptops'),
    (slug: 'fragrances', title: 'Fragancias'),
    (slug: 'mens-watches', title: 'Relojes para hombre'),
    (slug: 'furniture', title: 'Muebles'),
  ];

  int _currentIndex = BottomMenuIndex.home;

  void _onDestinationSelected(int index) {
    if (index == BottomMenuIndex.menu) {
      showThemeMenuSheet(context);
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Catálogo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoriesSection(),
            for (final section in _sections)
              ProductsSection(title: section.title, categorySlug: section.slug),
            const AppFooter(),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenuBar(
        currentIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/cart/presentation/widgets/card_button.dart';
import 'package:flutter_app/features/product/presentation/widgets/category/categories_section.dart';
import 'package:flutter_app/features/product/presentation/widgets/products_section.dart';
import 'package:flutter_app/features/shared/widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _sections = <({String slug, String title})>[
    (slug: 'smartphones', title: 'Smartphones'),
    (slug: 'laptops', title: 'Laptops'),
    (slug: 'fragrances', title: 'Fragancias'),
    (slug: 'mens-watches', title: 'Relojes para hombre'),
    (slug: 'furniture', title: 'Muebles'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Catálogo'),
        actions: const [CartButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoriesSection(),
            for (final section in _sections)
              ProductsSection(title: section.title, categorySlug: section.slug),
            SizedBox(),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

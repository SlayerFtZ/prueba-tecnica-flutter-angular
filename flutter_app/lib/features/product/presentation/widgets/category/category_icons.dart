import 'package:flutter/material.dart';

abstract final class CategoryIcons {
  static const _fallback = Icons.category_outlined;

  static const _bySlug = <String, IconData>{
    'beauty': Icons.face_retouching_natural,
    'fragrances': Icons.spa_outlined,
    'furniture': Icons.chair_outlined,
    'groceries': Icons.local_grocery_store_outlined,
    'home-decoration': Icons.home_outlined,
    'kitchen-accessories': Icons.kitchen_outlined,
    'laptops': Icons.laptop_mac,
    'mens-shirts': Icons.checkroom,
    'mens-shoes': Icons.hiking,
    'mens-watches': Icons.watch_outlined,
    'mobile-accessories': Icons.headphones_outlined,
    'motorcycle': Icons.two_wheeler,
    'skin-care': Icons.water_drop_outlined,
    'smartphones': Icons.smartphone,
    'sports-accessories': Icons.sports_soccer,
    'sunglasses': Icons.wb_sunny_outlined,
    'tablets': Icons.tablet_mac,
    'tops': Icons.checkroom,
    'vehicle': Icons.directions_car_outlined,
    'womens-bags': Icons.shopping_bag_outlined,
    'womens-dresses': Icons.checkroom,
    'womens-jewellery': Icons.diamond_outlined,
    'womens-shoes': Icons.hiking,
    'womens-watches': Icons.watch_outlined,
  };

  static IconData of(String slug) => _bySlug[slug] ?? _fallback;
}

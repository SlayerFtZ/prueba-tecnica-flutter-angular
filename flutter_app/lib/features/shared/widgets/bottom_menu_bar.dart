// lib/features/shared/widgets/bottom_menu_bar.dart

import 'package:flutter/material.dart';

const double kBottomMenuBarHeight = 64.0;

class BottomMenuIndex {
  static const home = 0;
  static const search = 1;
  static const cart = 2;
  static const menu = 3;
}

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.cartCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: kBottomMenuBarHeight,
            child: Row(
              children: [
                _NavItem(
                  label: 'Inicio',
                  isActive: currentIndex == BottomMenuIndex.home,
                  onTap: () => onDestinationSelected(BottomMenuIndex.home),
                  iconBuilder: (color) =>
                      Icon(Icons.home_rounded, color: color, size: 24),
                ),
                _NavItem(
                  label: 'Buscar',
                  isActive: currentIndex == BottomMenuIndex.search,
                  onTap: () => onDestinationSelected(BottomMenuIndex.search),
                  iconBuilder: (color) =>
                      Icon(Icons.search_rounded, color: color, size: 24),
                ),
                _NavItem(
                  label: 'Carrito',
                  isActive: currentIndex == BottomMenuIndex.cart,
                  onTap: () => onDestinationSelected(BottomMenuIndex.cart),
                  iconBuilder: (color) => Badge(
                    isLabelVisible: cartCount > 0,
                    label: Text(cartCount > 99 ? '99+' : '$cartCount'),
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: color,
                      size: 24,
                    ),
                  ),
                ),
                _NavItem(
                  label: 'Theme',
                  isActive: currentIndex == BottomMenuIndex.menu,
                  onTap: () => onDestinationSelected(BottomMenuIndex.menu),
                  iconBuilder: (color) =>
                      Icon(Icons.palette_rounded, color: color, size: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.iconBuilder,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Widget Function(Color color) iconBuilder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color color = isActive
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isActive,
        label: label,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconBuilder(color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/category.dart';
import 'package:flutter_app/features/product/presentation/widgets/category_icons.dart';

const _listPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
const _itemSpacing = 16.0;
const _circleSize = 64.0;
const _itemWidth = 76.0;
const _labelHeight = 32.0;
const _carouselHeight = _circleSize + 8 + _labelHeight;

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<Category> categories;
  final ValueChanged<Category> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _carouselHeight + _listPadding.vertical,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: _listPadding,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: _itemSpacing),
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryItem(
            category: category,
            onTap: () => onCategoryTap(category),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: _itemWidth,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer,
              ),
              child: Icon(
                CategoryIcons.of(category.slug),
                size: 28,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: _labelHeight,
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesCarouselPlaceholder extends StatelessWidget {
  const CategoriesCarouselPlaceholder({super.key});

  static const _count = 6;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      height: _carouselHeight + _listPadding.vertical,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: _listPadding,
        itemCount: _count,
        separatorBuilder: (_, _) => const SizedBox(width: _itemSpacing),
        itemBuilder: (_, _) => SizedBox(
          width: _itemWidth,
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: const SizedBox(width: _circleSize, height: _circleSize),
              ),
              const SizedBox(height: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const SizedBox(width: 50, height: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

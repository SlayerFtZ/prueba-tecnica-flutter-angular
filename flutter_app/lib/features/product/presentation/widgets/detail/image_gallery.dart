import 'package:flutter/material.dart';
import 'package:flutter_app/config/constants/app_durations.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_badge.dart';

const _galleryHeight = 320.0;
const _pagePadding = 16.0;

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key, required this.images, required this.soldOut});

  final List<String> images;
  final bool soldOut;

  @override
  State<ImageGallery> createState() => ImageGalleryState();
}

class ImageGalleryState extends State<ImageGallery> {
  // Estado puramente visual (página actual del carrusel).
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: AppDurations.medium,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasMany = widget.images.length > 1;

    return Column(
      children: [
        Container(
          height: _galleryHeight,
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(
                    widget.images[index],
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) =>
                        progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                    errorBuilder: (_, _, _) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              if (widget.soldOut)
                const Positioned(
                  top: 14,
                  left: 14,
                  child: ProductBadge(
                    label: 'Agotado',
                    background: Colors.black87,
                  ),
                ),
              if (hasMany)
                Positioned(
                  top: 14,
                  right: 14,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Text(
                        '${_page + 1}/${widget.images.length}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (hasMany)
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(
                _pagePadding,
                12,
                _pagePadding,
                0,
              ),
              itemCount: widget.images.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                final selected = index == _page;
                return GestureDetector(
                  onTap: () => _goTo(index),
                  child: AnimatedContainer(
                    duration: AppDurations.short,
                    width: 52,
                    height: 52,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? colors.primary
                            : colors.outlineVariant,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.contain,
                      cacheWidth: 120,
                      errorBuilder: (_, _, _) => Icon(
                        Icons.image_not_supported_outlined,
                        size: 18,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_badge.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.url, required this.soldOut});

  static const _cacheWidth = 360;

  final String url;
  final bool soldOut;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: colors.surfaceContainerHighest),
          Image.network(
            url,
            fit: BoxFit.contain,
            cacheWidth: _cacheWidth,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
            errorBuilder: (_, _, _) => Icon(
              Icons.image_not_supported_outlined,
              color: colors.onSurfaceVariant,
            ),
          ),
          if (soldOut)
            const Positioned(
              top: 6,
              left: 6,
              child: ProductBadge(label: 'Agotado', background: Colors.black87),
            ),
        ],
      ),
    );
  }
}

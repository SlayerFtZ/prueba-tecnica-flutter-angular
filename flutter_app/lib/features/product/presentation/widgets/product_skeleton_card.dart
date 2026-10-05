import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  static const _padding = 7.0;
  static const _nameHeight = 40.0;
  static const _discountRowHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: ProductCard.width,
      height: ProductCard.height,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: colors.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          // Skeletonizer va dentro del Card para que el borde y el fondo
          // de la tarjeta no se conviertan en "hueso".
          child: Skeletonizer(
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Bone(
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 8),
                Bone(
                  width: 70,
                  height: 12,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(
                  height: _nameHeight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Bone.multiText(lines: 2),
                  ),
                ),
                Bone(
                  width: 110,
                  height: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: _discountRowHeight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Bone(
                      width: 90,
                      height: 14,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Bone(
                            width: 80,
                            height: 18,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(height: 4),
                          Bone(
                            width: 60,
                            height: 11,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ),
                    const Bone.circle(size: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

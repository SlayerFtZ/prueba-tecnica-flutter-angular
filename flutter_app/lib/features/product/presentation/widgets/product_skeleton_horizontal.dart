import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_card_horizontal.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCardHorizontalSkeleton extends StatelessWidget {
  const ProductCardHorizontalSkeleton({super.key});

  static const _padding = 7.0;
  static const _imageWidth = 120.0;
  static const _discountRowHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: ProductCardHorizontal.height,
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
          child: Skeletonizer(
            enabled: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: _imageWidth,
                  child: Bone(borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Bone(
                        width: 70,
                        height: 12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 6),
                      const Bone.multiText(lines: 2),
                      const SizedBox(height: 6),
                      Bone(
                        width: 110,
                        height: 14,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const Spacer(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

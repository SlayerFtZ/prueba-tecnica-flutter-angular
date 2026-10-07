import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product_review.dart';
import 'package:flutter_app/features/product/presentation/widgets/product_rating_row.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({
    super.key,
    required this.reviews,
    required this.average,
  });

  final List<ProductReview> reviews;
  final double average;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final total = reviews.length;

    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              average.toStringAsFixed(1),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            ProductRatingRow(rating: average),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              for (var stars = 5; stars >= 1; stars--)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                        child: Text(
                          '$stars',
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 6),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: total == 0
                              ? 0
                              : reviews.where((r) => r.rating == stars).length /
                                    total,
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(100),
                          backgroundColor: colors.surfaceContainerHighest,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

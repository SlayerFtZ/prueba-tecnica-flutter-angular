// ─── Opiniones ────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product_review.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/rating_summary.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/review_tile.dart';
import 'package:flutter_app/features/product/presentation/widgets/detail/section.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.average,
  });

  final List<ProductReview> reviews;
  final double average;

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Opiniones (${reviews.length})',
      icon: Icons.chat_bubble_outline_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingSummary(reviews: reviews, average: average),
          const SizedBox(height: 8),
          for (final review in reviews) ...[
            const Divider(height: 24),
            ReviewTile(review: review),
          ],
        ],
      ),
    );
  }
}

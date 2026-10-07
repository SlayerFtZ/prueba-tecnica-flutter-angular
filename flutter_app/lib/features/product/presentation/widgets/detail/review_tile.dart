import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product_review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});

  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final date = review.date.toLocal();
    final dateLabel =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
    final initial = review.reviewerName.isNotEmpty
        ? review.reviewerName.characters.first.toUpperCase()
        : '?';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: colors.secondaryContainer,
          child: Text(
            initial,
            style: TextStyle(
              color: colors.onSecondaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      review.reviewerName,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    dateLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  for (var i = 1; i <= 5; i++)
                    Icon(
                      i <= review.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    ),
                ],
              ),
              if (review.comment.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(review.comment, style: theme.textTheme.bodyMedium),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

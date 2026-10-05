import 'package:flutter/material.dart';

class ProductRatingRow extends StatelessWidget {
  const ProductRatingRow({super.key, required this.rating});

  static const _starCount = 5;
  static const _starSize = 14.0;

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _starCount; i++)
          Icon(_iconFor(i), size: _starSize, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }

  IconData _iconFor(int index) {
    if (rating >= index + 1) return Icons.star;
    if (rating >= index + 0.5) return Icons.star_half;
    return Icons.star_border;
  }
}

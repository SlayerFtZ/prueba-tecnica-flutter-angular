import 'package:flutter/foundation.dart';

@immutable
class ProductReview {
  const ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      reviewerName: json['reviewerName'] as String? ?? 'Anónimo',
    );
  }

  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
}

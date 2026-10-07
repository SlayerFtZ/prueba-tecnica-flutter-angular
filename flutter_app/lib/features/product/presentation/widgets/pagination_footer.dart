import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/presentation/providers/products_pagination_provider.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.state, required this.onRetry});

  final ProductsPaginationState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurfaceVariant;
    if (state.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      );
    }

    if (state.hasReachedEnd) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              'No hay más productos',
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ],
        ),
      );
    }

    return const SizedBox(height: 20);
  }
}

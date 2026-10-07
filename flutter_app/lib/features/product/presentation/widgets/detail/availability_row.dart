import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';

const _lowStockThreshold = 10;

class AvailabilityRow extends StatelessWidget {
  const AvailabilityRow({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final stock = product.stock;

    final (IconData icon, Color color, String text) = switch (stock) {
      <= 0 => (Icons.block, colors.error, 'Producto agotado'),
      <= _lowStockThreshold => (
        Icons.local_fire_department_outlined,
        Colors.orange.shade800,
        '¡Solo quedan $stock unidades!',
      ),
      _ => (
        Icons.check_circle_outline,
        Colors.green.shade700,
        'Disponible ($stock en stock)',
      ),
    };

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

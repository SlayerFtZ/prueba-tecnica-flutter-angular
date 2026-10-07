import 'package:flutter/material.dart';

class ProductAddButton extends StatelessWidget {
  const ProductAddButton({super.key, required this.onPressed});

  static const _size = 30.0;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return IconButton.filled(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(_size),
        padding: EdgeInsets.zero,
        iconSize: 18,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
    );
  }
}

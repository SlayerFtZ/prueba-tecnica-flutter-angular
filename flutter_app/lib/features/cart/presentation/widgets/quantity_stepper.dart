import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isLast = quantity <= 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: isLast ? 'Quitar' : 'Disminuir',
          visualDensity: VisualDensity.compact,
          icon: Icon(
            isLast ? Icons.delete_outline_rounded : Icons.remove_rounded,
            size: 18,
          ),
          onPressed: isLast ? onRemove : onDecrease,
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        IconButton.outlined(
          tooltip: 'Aumentar',
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.add_rounded, size: 18),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}

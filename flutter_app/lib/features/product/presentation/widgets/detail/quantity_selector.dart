import 'package:flutter/material.dart';
import 'package:flutter_app/features/product/domain/entities/product.dart';
import 'package:flutter_app/features/product/presentation/providers/product_quantity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantitySelector extends ConsumerWidget {
  const QuantitySelector({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final quantity = ref.watch(productQuantityProvider(product.id));
    final notifier = ref.read(productQuantityProvider(product.id).notifier);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Text(
              'Cantidad',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton.filledTonal(
              tooltip: 'Quitar uno',
              icon: const Icon(Icons.remove),
              onPressed: quantity > 1 ? notifier.decrease : null,
            ),
            SizedBox(
              width: 44,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconButton.filledTonal(
              tooltip: 'Agregar uno',
              icon: const Icon(Icons.add),
              onPressed: quantity < product.stock
                  ? () => notifier.increase(product.stock)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

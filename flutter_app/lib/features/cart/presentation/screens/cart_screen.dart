import 'package:flutter/material.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';

import 'package:flutter_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter_app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter_app/features/cart/presentation/widgets/checkout_bar_button.dart';
import 'package:flutter_app/features/cart/presentation/widgets/delete_background.dart';
import 'package:flutter_app/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_app/features/cart/presentation/widgets/swipe_hint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider).items;
    final total = ref.watch(cartTotalProvider);
    final count = ref.watch(cartCountProvider);
    final notifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
        centerTitle: true,
        actions: [
          if (items.isNotEmpty)
            IconButton(
              tooltip: 'Vaciar carrito',
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: () async {
                final ok = await _confirm(
                  context,
                  title: 'Vaciar carrito',
                  message: '¿Quieres quitar todos los productos?',
                  action: 'Vaciar',
                );
                if (ok) notifier.clear();
              },
            ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: items.isEmpty
            ? EmptyCart(onAddPressed: () => context.go(AppRoutes.search))
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = items[index];

                        Future<bool> confirmRemove() => _confirm(
                          context,
                          title: 'Quitar producto',
                          message: '¿Quitar “${item.title}” del carrito?',
                          action: 'Quitar',
                        );

                        final card = Dismissible(
                          key: ValueKey(item.productId),
                          direction: DismissDirection.endToStart,
                          background: const DeleteBackground(),
                          confirmDismiss: (_) => confirmRemove(),
                          onDismissed: (_) => notifier.remove(item.productId),
                          child: CartItemCard(
                            item: item,
                            onIncrease: () =>
                                notifier.increment(item.productId),
                            onDecrease: () =>
                                notifier.decrement(item.productId),
                            onRemove: () async {
                              if (await confirmRemove()) {
                                notifier.remove(item.productId);
                              }
                            },
                          ),
                        );

                        return index == 0
                            ? SwipeHint(
                                key: const ValueKey('swipe-hint'),
                                child: card,
                              )
                            : card;
                      },
                    ),
                  ),
                  CheckoutBar(
                    total: total,
                    itemCount: count,
                    onCheckout: () async {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) => AlertDialog(
                          icon: Icon(
                            Icons.check_circle_rounded,
                            size: 48,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                          title: const Text('¡Compra realizada!'),
                          content: Text(
                            '$count ${count == 1 ? 'artículo' : 'artículos'} '
                            'por ${PriceFormatter.format(total)}.\n'
                            'Esta es una compra simulada.',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Aceptar'),
                            ),
                          ],
                        ),
                      );
                      notifier.clear();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String message,
  required String action,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(action),
        ),
      ],
    ),
  );
  return result ?? false;
}

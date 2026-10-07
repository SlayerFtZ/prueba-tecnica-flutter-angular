import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/price_formatter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CheckoutBar extends StatefulWidget {
  const CheckoutBar({
    super.key,
    required this.total,
    required this.itemCount,
    required this.onCheckout,
  });

  final double total;
  final int itemCount;
  final Future<void> Function() onCheckout;

  @override
  State<CheckoutBar> createState() => CheckoutBarState();
}

class CheckoutBarState extends State<CheckoutBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _wave;

  @override
  void initState() {
    super.initState();
    _wave = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _wave.dispose();
    super.dispose();
  }

  double _arrowOpacity(int index) {
    final t = (_wave.value + index * 0.28) % 1.0;
    return (sin(t * 2 * pi) * 0.5 + 0.5).clamp(0.15, 1.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final count = widget.itemCount;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '$count ${count == 1 ? 'artículo' : 'artículos'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text('Total ', style: theme.textTheme.bodyMedium),
              Text(
                PriceFormatter.format(widget.total),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _wave,
                builder: (context, _) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (index) => Opacity(
                      opacity: _arrowOpacity(index),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                'Desliza el botón para finalizar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SlideAction(
            height: 58,
            borderRadius: 25,
            elevation: 0,
            innerColor: scheme.onPrimary,
            outerColor: scheme.primary,
            sliderRotate: true,
            sliderButtonIconPadding: 12,
            sliderButtonIcon: Icon(
              Icons.shopping_cart_checkout_outlined,
              color: scheme.primary,
            ),
            submittedIcon: Icon(
              Icons.check_circle_outline_rounded,
              color: scheme.primary,
            ),
            text: 'Finalizar compra',
            textStyle: TextStyle(
              color: scheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            onSubmit: () async {
              await widget.onCheckout();
              return null;
            },
          ),
        ],
      ),
    );
  }
}

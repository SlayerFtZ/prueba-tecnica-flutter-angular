import 'package:flutter/material.dart';
import 'package:flutter_app/features/cart/presentation/widgets/delete_background.dart';

class SwipeHint extends StatefulWidget {
  const SwipeHint({super.key, required this.child});

  final Widget child;

  @override
  State<SwipeHint> createState() => SwipeHintState();
}

class SwipeHintState extends State<SwipeHint>
    with SingleTickerProviderStateMixin {
  static const _extent = 96.0;

  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _offset = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween<double>(0), weight: 5),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 4,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 2),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 5,
      ),
    ]).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      child: widget.child,
      builder: (context, child) {
        final value = _offset.value;

        return Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Visibility(
                visible: value > 0,
                child: const DeleteBackground(),
              ),
            ),
            Transform.translate(
              offset: Offset(-_extent * value, 0),
              child: child,
            ),
          ],
        );
      },
    );
  }
}

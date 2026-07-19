import 'package:flutter/material.dart';
import '../state/app_settings.dart';

class AnimatedEntranceTile extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  final Widget child;

  const AnimatedEntranceTile({
    super.key,
    required this.index,
    required this.onTap,
    required this.child,
  });

  @override
  State<AnimatedEntranceTile> createState() => _AnimatedEntranceTileState();
}

class _AnimatedEntranceTileState extends State<AnimatedEntranceTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppSettings.reduceMotion,
      builder: (context, reduceMotion, _) {
        final tile = GestureDetector(
          onTap: widget.onTap,
          onTapDown: reduceMotion ? null : (_) => setState(() => _pressed = true),
          onTapUp: reduceMotion ? null : (_) => setState(() => _pressed = false),
          onTapCancel:
              reduceMotion ? null : () => setState(() => _pressed = false),
          child: AnimatedScale(
            scale: (!reduceMotion && _pressed) ? 0.96 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: widget.child,
          ),
        );

        if (reduceMotion) return tile;

        // Staggered entrance: each tile fades/slides in slightly after the
        // previous one, driven purely by an implicit animation keyed off
        // a delayed TweenAnimationBuilder rather than a full
        // AnimationController — simpler for a one-shot effect like this.
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 320 + widget.index * 60),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 16),
                child: child,
              ),
            );
          },
          child: tile,
        );
      },
    );
  }
}

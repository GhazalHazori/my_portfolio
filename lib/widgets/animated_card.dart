// lib/ui/shared/animated_cards.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollAnimatedCard extends StatefulWidget {
  final Widget child;
  final int delay;
  const ScrollAnimatedCard({required this.child, required this.delay, Key? key}) : super(key: key);

  @override
  State<ScrollAnimatedCard> createState() => _ScrollAnimatedCardState();
}

class _ScrollAnimatedCardState extends State<ScrollAnimatedCard> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          Future.delayed(Duration(milliseconds: widget.delay), () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _visible ? 1 : 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(_visible ? 0 : 60, 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}

class AnimatedHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedHoverCard({required this.child, required this.onTap, Key? key}) : super(key: key);

  @override
  State<AnimatedHoverCard> createState() => _AnimatedHoverCardState();
}

class _AnimatedHoverCardState extends State<AnimatedHoverCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovering
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? Colors.blueAccent.withOpacity(0.35)
                  : Colors.white.withOpacity(0.05),
              blurRadius: _hovering ? 18 : 5,
              spreadRadius: _hovering ? 3 : 0.5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(14),
          child: widget.child,
        ),
      ),
    );
  }
}

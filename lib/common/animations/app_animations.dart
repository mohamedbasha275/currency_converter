import 'package:flutter/material.dart';

Route pageRoute({
  required Widget page,
  Duration duration = const Duration(milliseconds: 300),
  RouteSettings? settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return ScaleTransition(
        scale: fadeAnimation,
        child: FadeTransition(opacity: fadeAnimation, child: child),
      );
    },
  );
}

class AnimatedTabContent extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final Duration duration;

  const AnimatedTabContent({
    super.key,
    required this.currentIndex,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  Widget tabContentTransition({
    required Widget child,
    required Animation<double> animation,
    required bool forward,
  }) {
    final offsetAnim = Tween<Offset>(
      begin: Offset(forward ? 0.2 : -0.2, 0),
      end: Offset.zero,
    ).animate(animation);

    return SlideTransition(
      position: offsetAnim,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return tabContentTransition(
          child: child,
          animation: animation,
          forward: true,
        );
      },
      child: KeyedSubtree(key: ValueKey<int>(currentIndex), child: child),
    );
  }
}

class AnimatedActiveTabIcon extends StatelessWidget {
  final Widget icon;
  final Curve curve;

  const AnimatedActiveTabIcon({
    super.key,
    required this.icon,
    this.curve = Curves.easeInToLinear,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: curve,
      builder: (context, scale, _) {
        return Transform.scale(scale: scale, child: icon);
      },
    );
  }
}

Future showAnimatedBottomSheet({
  required BuildContext context,
  required Widget child,
  Duration duration = const Duration(milliseconds: 350),
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: duration,
      reverseDuration: const Duration(milliseconds: 350),
    ),
    builder: (context) {
      return AnimatedBuilder(
        animation: ModalRoute.of(context)!.animation!,
        builder: (context, child) {
          final animation = ModalRoute.of(context)!.animation!;
          final curvedValue = Curves.easeOutQuart.transform(animation.value);

          return Transform.translate(
            offset: Offset(0, 50 * (1 - curvedValue)),
            child: Opacity(
              opacity: Curves.easeOut.transform(animation.value),
              child: child,
            ),
          );
        },
        child: child,
      );
    },
  );
}

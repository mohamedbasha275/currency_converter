import 'package:flutter/material.dart';
import 'package:currency_converter/core/resources/app_colors.dart';

/// ===========================================================================
///  PAGE TRANSITIONS (Reusable)
/// ===========================================================================
Route pageRoute({
  required Widget page,
  Duration duration = const Duration(milliseconds: 300),
  RouteSettings? settings,
}) {
  // return PageRouteBuilder(
  //   settings: settings,
  //   pageBuilder: (context, animation, secondaryAnimation) => page,
  //   transitionDuration: duration,
  //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //     final slide = Tween<Offset>(
  //       begin: const Offset(1.0, 0.0),
  //       end: Offset.zero,
  //     ).animate(
  //       CurvedAnimation(parent: animation, curve: Curves.easeOut),
  //     );
  //
  //     final fade = Tween<double>(
  //       begin: 0.0,
  //       end: 1.0,
  //     ).animate(
  //       CurvedAnimation(parent: animation, curve: Curves.easeOut),
  //     );
  //
  //     return SlideTransition(
  //       position: slide,
  //       child: FadeTransition(
  //         opacity: fade,
  //         child: ScaleTransition(
  //           scale: fade,
  //           child: child,
  //         ),
  //       ),
  //     );
  //   },
  // );

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide from right + Fade
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      return ScaleTransition(
        // ScaleTransition - SlideTransition
        // position: offsetAnimation,
        scale: fadeAnimation,
        child: FadeTransition(opacity: fadeAnimation, child: child),
      );
    },
  );
}

/// More transitions? Add here…

/// ===========================================================================
///  TAB CONTENT ANIMATION (AnimatedSwitcher Wrapper)
/// ===========================================================================

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

/// Helper widget ready to use
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

//body: AnimatedSwitcher(
//   duration: const Duration(milliseconds: 350),
//   switchInCurve: Curves.easeOutCubic,
//   switchOutCurve: Curves.easeInCubic,
//   transitionBuilder: (child, animation) {
//     final fade = Tween<double>(begin: 0, end: 1).animate(animation);
//     final slide = Tween<Offset>(
//       begin: const Offset(0.1, 0),   // حركة بسيطة لليمين
//       end: Offset.zero,
//     ).animate(animation);
//     final scale = Tween<double>(begin: 0.98, end: 1.0).animate(animation);
//
//     return FadeTransition(
//       opacity: fade,
//       child: SlideTransition(
//         position: slide,
//         child: ScaleTransition(
//           scale: scale,
//           child: child,
//         ),
//       ),
//     );
//   },
//   child: Container(
//     key: ValueKey(cubit.currentIndex),
//     child: clientTabs[cubit.currentIndex],
//   ),
// ),
//  body: AnimatedSwitcher(
//       duration: const Duration(milliseconds: 400),
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         return FadeTransition(
//           opacity: animation,
//           child: SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0.1, 0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         key: ValueKey<int>(cubit.currentIndex),
//         child: clientTabs[cubit.currentIndex],
//       ),
//     ),
// body: AnimatedSwitcher(
//   duration: const Duration(milliseconds: 300),
//   transitionBuilder: (child, animation) {
//     final offsetAnimation = Tween<Offset>(
//       begin: const Offset(0.1, 0),
//       end: Offset.zero,
//     ).animate(animation);
//
//     return SlideTransition(
//       position: offsetAnimation,
//       child: FadeTransition(opacity: animation, child: child),
//     );
//   },
//   child: KeyedSubtree(
//     key: ValueKey<int>(cubit.currentIndex),
//     child: clientTabs[cubit.currentIndex],
//   ),
// ),

/// ===========================================================================
///  TAB ICON ANIMATION (for BottomNavigationBar)
/// ===========================================================================
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
        return Transform.scale(
          scale: scale,
          child: icon,
        );
      },
    );
  }
}


// Widget animatedActiveTabIcon({Color? color, required Widget icon}) {
//   return TweenAnimationBuilder<double>(
//     tween: Tween(begin: 0.01, end: 1.15),
//     duration: const Duration(milliseconds: 300),
//     curve: Curves.linear, //change
//     builder: (context, scale, child) {
//       return Transform.scale(
//         scale: scale,
//         child: Container(
//           height: 50,
//           width: 50,
//           padding: const EdgeInsets.all(13),
//           decoration: BoxDecoration(
//             color:color??  AppColors.primary,
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: icon,
//         ),
//       );
//     },
//   );
// }


class AnimatedTabIcon extends StatelessWidget {
  final Widget activeIcon;
  final Widget inactiveIcon;
  final bool isActive;
  final Duration duration;
  final double beginScale;
  final double endScale;

  const AnimatedTabIcon({
    super.key,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.isActive,
    this.duration = const Duration(milliseconds: 300),
    this.beginScale = 0.01,
    this.endScale = 1.15,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(
        begin: isActive ? beginScale : endScale,
        end: isActive ? endScale : beginScale,
      ),
      curve: Curves.linear,
      builder: (_, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: isActive ? activeIcon : inactiveIcon,
    );
  }
}

/// ===========================================================================
///  DIALOG ANIMATION (Reusable Animated Dialog)
/// ===========================================================================
Future showAnimatedDialog({
  required BuildContext context,
  required Widget child,
  Duration duration = const Duration(milliseconds: 300),
  bool barrierDismissible = true,
  Color? barrierColor,
  String barrierLabel = 'Dismiss',
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.2),
    transitionDuration: duration,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}

/// ===========================================================================
///  BOTTOM SHEET ANIMATION (Reusable Animated Modal Bottom Sheet)
/// ===========================================================================

extension SwitchAnimation on Switch {
  Widget animateSwitch({
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: this,
    );
  }
}

/// ===========================================================================
///  BOTTOM SHEET ANIMATION (Reusable Animated Modal Bottom Sheet)
/// ===========================================================================
Widget animatedSlide({required Widget child, required bool isActive}) {
  // first
  // return AnimatedScale(
  //   duration: const Duration(seconds: 2),
  //   curve: Curves.easeInOut,
  //   scale: isActive ? 1.0 : 0.95,
  //   child: child,
  // );
  // 2
  return AnimatedSlide(
    duration: const Duration(milliseconds: 1500),
    curve: Curves.easeInOut,
    offset: isActive ? Offset.zero : const Offset(0, 0.2),
    child: AnimatedScale(
      duration: const Duration(seconds: 1),
      scale: 1,
      child: child,
    ),
  );
  return AnimatedSlide(
    duration: const Duration(seconds: 1),
    curve: Curves.easeInOut,
    offset: Offset.zero,
    child: AnimatedScale(
      duration: const Duration(seconds: 1),
      scale: 1,
      child: child,
    ),
  );
  return AnimatedScale(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOutCubic,
    scale: isActive ? 1.0 : 0.88,
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isActive ? 1.0 : 0.6,
      child: child,
    ),
  );
}

/// ===========================================================================
///  BOTTOM SHEET ANIMATION (Reusable Animated Modal Bottom Sheet)
/// ===========================================================================

// Future showAnimatedBottomSheet({
//   required BuildContext context,
//   required Widget child,
//   Duration duration = const Duration(milliseconds: 900),
//   bool isDismissible = true,
//   bool enableDrag = true,
// }) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     isDismissible: isDismissible,
//     enableDrag: enableDrag,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return TweenAnimationBuilder<double>(
//         duration: duration,
//         curve: Curves.easeOut,
//         tween: Tween(begin: 0.0, end: 1.0),
//         builder: (context, value, _) {
//           return Transform.translate(
//             offset: Offset(0, 50 * (1 - value)),
//             child: Opacity(opacity: value, child: child),
//           );
//         },
//       );
//     },
//   );
// }

Future showAnimatedBottomSheet({
  required BuildContext context,
  required Widget child,
  Duration duration = const Duration(milliseconds:350),
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
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
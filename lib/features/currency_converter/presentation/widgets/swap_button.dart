import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SwapButton extends HookWidget {
  final bool isHistory;
  final VoidCallback onTap;

  const SwapButton({super.key, required this.onTap, this.isHistory = false});

  @override
  Widget build(BuildContext context) {
    final swapTurns = useState(0.0);

    final button = InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        swapTurns.value += 0.5;
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 2)],
        ),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary2,
            shape: BoxShape.circle,
          ),
          child: AnimatedRotation(
            turns: swapTurns.value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Icon(
              isHistory ? Icons.swap_horiz_rounded : Icons.swap_vert,
              color: AppColors.iconColor,
            ),
          ),
        ),
      ),
    );

    if (isHistory) {
      return Center(child: button);
    }

    return Positioned(
      left: 0,
      right: 0,
      top: context.screenHeight * 0.26,
      child: button,
    );
  }
}

import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class  AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? function;
  const  AppErrorWidget({super.key, required this.message, this.function});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 80,
              color: AppColors.nearBlueGrey.withValues(alpha: 0.3),
            ),
            20.heightBox,
             AppText(
              'Connection Error',
              style: AppTextStyles.highlightBlackSemi,
            ),
            12.heightBox,
             AppText(
              message,
              style: AppTextStyles.bodyMedBlueGrey,
              align: TextAlign.center,
            ),
            24.heightBox,
            ElevatedButton.icon(
              onPressed: function,
              icon: Icon(Icons.refresh, color: AppColors.iconColor),
              label:  AppText(
                'Try Again',
                style: AppTextStyles.bodyMedBlueGrey.copyWith(
                  color: AppColors.iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

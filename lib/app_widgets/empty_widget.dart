import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppEmptyWidget extends StatelessWidget {
  final String message;
  const AppEmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: AppColors.nearBlueGrey.withValues(alpha: 0.3),
          ),
          16.heightBox,
          AppText(
           message,
            style: AppTextStyles.highlightBlackSemi,
          ),
          8.heightBox,
          AppText(
            'Try searching with different keywords',
            style: AppTextStyles.bodyMedBlueGrey,
          ),

        ],
      ),
    );
  }
}

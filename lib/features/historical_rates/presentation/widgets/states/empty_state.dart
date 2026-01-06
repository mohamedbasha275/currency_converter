import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 80, color: AppColors.primary),
          20.heightBox,
          AppText(
            'Select currencies and view historical rates',
            style: AppTextStyles.subtitleBlackSemi,
          ),
        ],
      ),
    );
  }
}















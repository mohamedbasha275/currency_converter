import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Rate History', style: AppTextStyles.displayBlackBold),
        AppText('Track exchange rates over time', style: AppTextStyles.titleMedGrey),
        24.heightBox,
      ],
    );
  }
}








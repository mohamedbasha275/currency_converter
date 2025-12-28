
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';


class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
   const CustomFormField({super.key, this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.convertCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: AppTextStyles.headingMain,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: '0.00',
          hintStyle: TextStyle(color: AppColors.nearBlueGrey),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

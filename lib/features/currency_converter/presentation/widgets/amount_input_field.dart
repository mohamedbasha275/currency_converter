import 'package:currency_converter/common/custom_form_field.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const AmountInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Amount', style: AppTextStyles.bodyMedBlueGrey),
        8.heightBox,
        CustomFormField(
          controller: controller,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

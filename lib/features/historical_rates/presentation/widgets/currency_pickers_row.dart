
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_converter/presentation/widgets/swap_button.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/currency_picker.dart';
import 'package:flutter/material.dart';

class CurrencyPickersRow extends StatelessWidget {
  final String fromCode;
  final String toCode;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final VoidCallback onSwap;

  const CurrencyPickersRow({
    super.key,
    required this.fromCode,
    required this.toCode,
    required this.onFromTap,
    required this.onToTap,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('FROM', style: AppTextStyles.bodyMedBlueGrey),
              8.heightBox,
              CurrencyPickerPill(code: fromCode, onTap: onFromTap),
            ],
          ),
        ),
        12.heightBox,
        SizedBox(width: 100, child: SwapButton(onTap: onSwap, isHistory: true)),
        12.heightBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('TO', style: AppTextStyles.bodyMedBlueGrey),
              8.heightBox,
              CurrencyPickerPill(code: toCode, onTap: onToTap),
            ],
          ),
        ),
      ],
    );
  }
}



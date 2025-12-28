import 'package:currency_converter/app_widgets/currency_flag.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:flutter/material.dart';

class CurrencySelectTile extends StatelessWidget {
  final String label;
  final CurrencyListEntity currency;
  final VoidCallback onTap;

  const CurrencySelectTile({
    super.key,
    required this.label,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: AppTextStyles.bodyMedBlueGrey),
        8.heightBox,
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.convertCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                CurrencyFlag(url:currency.flagUrl),
                12.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        currency.code,
                        style: AppTextStyles.subtitleBlackSemi,
                      ),
                      2.heightBox,
                      AppText(
                        currency.name,
                        style: AppTextStyles.bodyMedBlueGrey,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.dropDownIcon,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

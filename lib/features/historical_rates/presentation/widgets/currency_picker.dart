
import 'package:currency_converter/app_widgets/currency_flag.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/features/currency_list/data/helper/currency_data.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class CurrencyPickerPill extends StatelessWidget {
  final String code;
  final VoidCallback onTap;

  const CurrencyPickerPill({super.key, required this.code, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cc = CurrencyData.countryCode(code);
    final url = '$flagSite${cc.toLowerCase()}.png';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.background,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 2)],
        ),
        child: Row(
          children: [
            CurrencyFlag(url: url,size: 22,),
            12.widthBox,
            Expanded(
              child: AppText(code, style: AppTextStyles.highlightBlackBold),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.dropDownIcon,
            ),
          ],
        ),
      ),
    );
  }
}
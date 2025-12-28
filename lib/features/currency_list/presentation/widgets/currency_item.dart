
import 'package:currency_converter/app_widgets/currency_flag.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:flutter/material.dart';

class  CurrencyItem extends StatelessWidget {
  final CurrencyListEntity currency;
  final VoidCallback onTap;
  const  CurrencyItem({super.key, required this.currency,required this.onTap,});

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardBorder,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CurrencyFlag(url: currency.flagUrl),
            12.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        currency.code,
                        style: AppTextStyles.subtitleBlackSemi,
                      ),
                      AppText(
                        ' (${currency.symbol})',
                        style: AppTextStyles.subtitleBlackSemi,
                      ),
                    ],
                  ),
                  2.heightBox,
                  AppText(
                    currency.name,
                    style: AppTextStyles.bodyMedBlueGrey,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined,color: AppColors.dropDownIcon,size: 18,),
          ],
        ),
      ),
    );
  }
}

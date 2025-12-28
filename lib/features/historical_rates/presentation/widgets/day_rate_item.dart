import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:flutter/material.dart';

class DayRateItem extends StatelessWidget {
  final HistoricalRateEntity rate;

  const DayRateItem({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    final changeColor = rate.deltaPct > 0
        ? AppColors.upRate
        : AppColors.downRate;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(rate.dayName, style: AppTextStyles.subtitleBlackSemi),
                4.heightBox,
                AppText(
                  rate.formattedDate,
                  style: AppTextStyles.captionBlueGreyMed,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                rate.formattedRate,
                style: AppTextStyles.subtitleBlackSemi,
              ),
              4.heightBox,
              AppText(
                rate.formatDailyChange(rate.deltaPct),
                style: AppTextStyles.bodyMedBlueGrey.copyWith(
                  color: changeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

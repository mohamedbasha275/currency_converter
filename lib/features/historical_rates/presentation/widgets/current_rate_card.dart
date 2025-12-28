import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class CurrentRateCard extends StatelessWidget {
  final String from;
  final String to;
  final double currentRate;
  final double rateOf7d;
  final bool isUp;

  const CurrentRateCard({
    super.key,
    required this.from,
    required this.to,
    required this.currentRate,
    required this.rateOf7d,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    final pillBg = isUp ? AppColors.upRateBg : AppColors.downRateBg;
    final pillFg = isUp ? AppColors.upRate : AppColors.downRate;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.convertCard,
        borderRadius: BorderRadius.circular(22),
        boxShadow:  [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Expanded(
                child: AppText(
                  'CURRENT RATE',
                  style: AppTextStyles.subtitleNearBlueGreySemi,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: pillBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Icon(
                      isUp
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 18,
                      color: pillFg,
                    ),
                    4.widthBox,
                    Text(
                      '${rateOf7d.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: pillFg,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppText(
            currentRate.toStringAsFixed(4),
            style: AppTextStyles.displayBlackBold.copyWith(
              fontSize: 50),
          ),
          AppText(
            '$from → $to',
            style: AppTextStyles.subtitleNearBlueGreySemi,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: AppText(
              '7-day change',
              style: AppTextStyles.subtitleNearBlueGreySemi.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

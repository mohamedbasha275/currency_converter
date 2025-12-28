import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/rates_chart.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  final List<HistoricalRateEntity> rates;

  const ChartSection({
    super.key,
    required this.rates,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         AppText(
          '7-Day Trend',
          style: AppTextStyles.highlightBlackBold,
        ),
        12.heightBox,
        Container(
          height: context.screenHeight *0.3,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: RatesChart(rates: rates),
        ),
      ],
    );
  }
}


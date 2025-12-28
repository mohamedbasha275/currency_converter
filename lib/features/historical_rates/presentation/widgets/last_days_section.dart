import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/day_rate_item.dart';
import 'package:flutter/material.dart';

class LastDaysSection extends StatelessWidget {
  final List<HistoricalRateEntity> rates;

  const LastDaysSection({
    super.key,
    required this.rates,
  });

  @override
  Widget build(BuildContext context) {
    if (rates.isEmpty) return const SizedBox.shrink();
    final visibleCount = rates.length > 7 ? 7 : rates.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.heightBox,
         AppText(
          'LAST 7 DAYS',
          style: AppTextStyles.bodyMedBlueGrey,
        ),
        12.heightBox,
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:AppColors.shadow,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: List.generate(
              visibleCount,
              (i) {
                final rate = rates[i];
                return DayRateItem(
                  rate: rate,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

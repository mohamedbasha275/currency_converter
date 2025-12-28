import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultCard extends StatelessWidget {
  final CurrencyListEntity from;
  final CurrencyListEntity to;
  final double? exchangeRate;
  final double? convertedAmount;

  const ResultCard({
    super.key,
    required this.from,
    required this.to,
    this.exchangeRate,
    this.convertedAmount,
  });

  String _getCurrentTime() {
    final now = DateTime.now().toUtc();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    if (convertedAmount == null) return const SizedBox.shrink();

    final formatter = NumberFormat('#,##0.00', 'en_US');
    final rateFormatter = NumberFormat('#,##0.0000', 'en_US');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.convertCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          // Title
          AppText(
            'Total Estimated Result',
            style: AppTextStyles.subtitleNearBlueGreySemi,
          ),
          16.heightBox,
          // Converted Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                to.symbol,
                style: AppTextStyles.displayBlackBold.copyWith(
                  fontSize: 48,
                  height: 1.0,
                ),
              ),
              8.widthBox,
              AppText(
                formatter.format(convertedAmount),
                style: AppTextStyles.displayBlackBold.copyWith(
                  fontSize: 48,
                  height: 1.0,
                ),
              ),
            ],
          ),
          16.heightBox,

          if (exchangeRate != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              width: context.screenWidth *0.6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: AppColors.activeBadge,
                  ),
                  4.widthBox,
                  AppText(
                    '1 ${from.symbol} = ${rateFormatter.format(exchangeRate)} ${to.symbol}',
                    style: AppTextStyles.bodyMedBlueGrey,
                  ),
                ],
              ),
            ),
            12.heightBox,
            AppText(
              'Mid-market exchange rate at ${_getCurrentTime()} UTC. ',
              style: AppTextStyles.captionBlueGreyReg,
            ),
          ],
        ],
      ),
    );
  }
}

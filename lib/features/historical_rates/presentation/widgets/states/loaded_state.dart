import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/components/chart_section.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/components/currency_section.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/components/page_header.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/components/top_loader.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/current_rate_card.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/last_days_section.dart';
import 'package:flutter/material.dart';

class LoadedState extends StatelessWidget {
  final HistoricalRatesLoaded state;
  final String from;
  final String to;

  const LoadedState({
    super.key,
    required this.state,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    final rates = state.rates;
    final currentRate = rates.currentRate;
    final rateOf7d = rates.overallPercentageChange;
    final isUp = rateOf7d >= 0;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(),
              CurrencySection(from: from, to: to),
              16.heightBox,
              CurrentRateCard(
                from: from,
                to: to,
                currentRate: currentRate,
                rateOf7d: rateOf7d,
                isUp: isUp,
              ),
              16.heightBox,
             ChartSection(rates: rates),
              16.heightBox,
              LastDaysSection(rates: rates),
            ],
          ),
        ),
       if (state.isRefreshing) const TopLoader(),
      ],
    );
  }
}


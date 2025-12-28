import 'package:currency_converter/app_widgets/error_widget.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/states/empty_state.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/states/error_state.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/states/idle_state.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/states/loaded_state.dart';
import 'package:currency_converter/features/historical_rates/presentation/widgets/states/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricalRatesScreen extends StatelessWidget {
  const HistoricalRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricalRatesCubit, HistoricalRatesState>(

      builder: (context, state) {
        final cubit = context.read<HistoricalRatesCubit>();
        final from = cubit.fromCurrency ?? 'USD';
        final to = cubit.toCurrency ?? 'EUR';

        return switch (state) {
          HistoricalRatesInitial() => const EmptyState(),
          HistoricalRatesLoading() => LoadingState(
            from: from,
            to: to,
          ),
          HistoricalRatesError() => AppErrorWidget(
            message: state.message,
            function: cubit.getHistoricalRates,
          ),
          HistoricalRatesIdle() => IdleState(
            from: from,
            to: to,
            onShow: cubit.getHistoricalRates,
          ),
          HistoricalRatesLoaded() => LoadedState(
            state: state,
            from: from,
            to: to,
          ),
          _ => const EmptyState(),
        };
      },
    );
  }
}

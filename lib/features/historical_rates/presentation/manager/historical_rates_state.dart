part of 'historical_rates_cubit.dart';

abstract class HistoricalRatesState {}

class HistoricalRatesInitial extends HistoricalRatesState {}

class HistoricalRatesIdle extends HistoricalRatesState {
  final String fromCurrency;
  final String toCurrency;

  HistoricalRatesIdle({
    required this.fromCurrency,
    required this.toCurrency,
  });
}

class HistoricalRatesLoading extends HistoricalRatesState {}

class HistoricalRatesLoaded extends HistoricalRatesState {
  final List<HistoricalRateEntity> rates;
  final bool isRefreshing;
  final String? nonBlockingError;

  HistoricalRatesLoaded({
    required this.rates,
    required this.isRefreshing,
    this.nonBlockingError,
  });
}

class HistoricalRatesError extends HistoricalRatesState {
  final String message;

  HistoricalRatesError(this.message);
}

import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/domain/use_cases/get_historical_rates_use_case.dart';

part 'historical_rates_state.dart';

class HistoricalRatesCubit extends Cubit<HistoricalRatesState> {
  final GetHistoricalRatesUseCase getHistoricalRatesUseCase;

  HistoricalRatesCubit({required this.getHistoricalRatesUseCase})
    : super(HistoricalRatesInitial());

  static final Map<String, List<HistoricalRateEntity>> _ratesCache = {};

  String? fromCurrency;
  String? toCurrency;
  List<HistoricalRateEntity> _lastRates = const [];

  void setCurrencies(String from, String to) {
    if (fromCurrency == from && toCurrency == to) return;
    fromCurrency = from;
    toCurrency = to;
    emit(HistoricalRatesIdle(fromCurrency: from, toCurrency: to));
  }

  Future<void> getHistoricalRates({bool forceRefresh = false}) async {
    if (fromCurrency == null || toCurrency == null) {
      return;
    }

    final cacheKey = '${fromCurrency!}|${toCurrency!}';
    final cached = _ratesCache[cacheKey];
    if (!forceRefresh && cached != null && cached.isNotEmpty) {
      _lastRates = cached;
      emit(HistoricalRatesLoaded(rates: cached, isRefreshing: false));
      return;
    }

    final previousRates = switch (state) {
      HistoricalRatesLoaded s => s.rates,
      _ => _lastRates,
    };

    if (previousRates.isNotEmpty) {
      emit(HistoricalRatesLoaded(rates: previousRates, isRefreshing: true));
    } else {
      emit(HistoricalRatesLoading());
    }

    final result = await getHistoricalRatesUseCase.call(
      GetHistoricalRatesParams(from: fromCurrency!, to: toCurrency!),
    );

    result.fold(
      (failure) {
        if (previousRates.isNotEmpty) {
          emit(
            HistoricalRatesLoaded(
              rates: previousRates,
              isRefreshing: false,
              nonBlockingError: failure.message,
            ),
          );
        } else {
          emit(HistoricalRatesError(failure.message));
        }
      },
      (rates) {
        final ratesWithChanges = _calculateDailyChanges(rates);
        _lastRates = ratesWithChanges;
        _ratesCache[cacheKey] = ratesWithChanges;
        emit(HistoricalRatesLoaded(rates: ratesWithChanges, isRefreshing: false));
      },
    );
  }

  List<HistoricalRateEntity> _calculateDailyChanges(List<HistoricalRateEntity> rates) {
    if (rates.length < 2) return rates;

    final sorted = [...rates];
    sorted.sort((a, b) => a.date.compareTo(b.date));

    final withChanges = List.generate(sorted.length, (i) {
      final rate = sorted[i];
      final previousRate = i > 0 ? sorted[i - 1] : null;
      final deltaPct = rate.calculateDailyChange(previousRate);

      return HistoricalRateEntity(
        rate: rate.rate,
        date: rate.date,
        deltaPct: deltaPct,
      );
    });

    return withChanges.reversed.toList();
  }
}

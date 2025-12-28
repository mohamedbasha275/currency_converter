import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';
import 'package:currency_converter/features/currency_list/data/helper/currency_database_helper.dart';
import 'package:currency_converter/features/currency_converter/data/datasources/currency_converter_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/repositories/currency_converter_repository_impl.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/currency_list/data/datasources/currency_list_data_source.dart';
import 'package:currency_converter/features/currency_list/data/repositories/currency_list_repository_impl.dart';
import 'package:currency_converter/features/currency_list/domain/repositories/currency_list_repository.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/refresh_currencies_use_case.dart';
import 'package:currency_converter/features/historical_rates/data/datasources/historical_rates_data_source.dart';
import 'package:currency_converter/features/historical_rates/data/repositories/historical_rates_repository_impl.dart';
import 'package:currency_converter/features/historical_rates/domain/repositories/historical_rates_repository.dart';
import 'package:currency_converter/features/historical_rates/domain/use_cases/get_historical_rates_use_case.dart';

final getIt = GetIt.instance;

/// Call this once in `main()`
Future<void> setupServiceLocator() async {
  await _registerCore();
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
}
/* ─────────────────── CORE ─────────────────── */
Future<void> _registerCore() async {
  getIt
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()))
    ..registerLazySingleton<CurrencyDatabaseHelper>(
      () => CurrencyDatabaseHelper.instance,
    );

  final prefs = await SharedPreferences.getInstance();
  getIt
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerLazySingleton<AppPreferences>(() => AppPreferences(prefs));
}

/* ───────────────── DATA SOURCES ─────────────── */
void _registerDataSources() {
  getIt
    ..registerLazySingleton<CurrencyConverterDataSource>(
      () => CurrencyConverterDataSourceImpl(getIt<ApiService>()),
    )
    ..registerLazySingleton<CurrencyListDataSource>(
      () => CurrencyListDataSourceImpl(
        getIt<ApiService>(),
        getIt<CurrencyDatabaseHelper>(),
      ),
    )
    ..registerLazySingleton<HistoricalRatesDataSource>(
      () => HistoricalRatesDataSourceImpl(getIt<ApiService>()),
    );
}

/* ───────────────── REPOSITORIES ─────────────── */
void _registerRepositories() {
  getIt
    ..registerLazySingleton<CurrencyConverterRepository>(
      () =>
          CurrencyConverterRepositoryImpl(getIt<CurrencyConverterDataSource>()),
    )
    ..registerLazySingleton<CurrencyListRepository>(
      () => CurrencyListRepositoryImpl(getIt<CurrencyListDataSource>()),
    )
    ..registerLazySingleton<HistoricalRatesRepository>(
      () => HistoricalRatesRepositoryImpl(getIt<HistoricalRatesDataSource>()),
    );
}
/* ───────────────── USE CASES ───────────────── */

void _registerUseCases() {
  getIt
    ..registerLazySingleton(() => GetCurrenciesUseCase(getIt()))
    ..registerLazySingleton(() => RefreshCurrenciesUseCase(getIt()))
    ..registerLazySingleton(() => ConvertCurrencyUseCase(getIt()))
    ..registerLazySingleton(() => GetHistoricalRatesUseCase(getIt()));
}

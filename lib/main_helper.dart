// initializeApp
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/refresh_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/presentation/manager/currency_list_cubit.dart';
import 'package:currency_converter/features/historical_rates/domain/use_cases/get_historical_rates_use_case.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:currency_converter/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/core/bloc_observer/bloc_observer.dart';
import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/features/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  Bloc.observer = MyBlocObserver();
}

// getStartWidget
Future<Widget> getStartWidget() async {
  final AppPreferences appPreferences = getIt<AppPreferences>();
  final bool isOnBoardingViewed = appPreferences.isOnBoardingScreenViewed();
  if (isOnBoardingViewed) {
    return const HomeScreen();
  } else {
    return const OnBoardingScreen();
  }
}

// mainProviders
mainProviders() {
  return [
    BlocProvider(
      create: (_) => CurrencyConverterCubit(
        convertCurrencyUseCase: getIt<ConvertCurrencyUseCase>(),
      ),
    ),
    BlocProvider(
      create: (context) => CurrencyListCubit(
        getCurrenciesUseCase: getIt<GetCurrenciesUseCase>(),
        refreshCurrenciesUseCase: getIt<RefreshCurrenciesUseCase>(),
      )..getCurrencies(),
    ),
    BlocProvider(
      create: (_) => HistoricalRatesCubit(
        getHistoricalRatesUseCase: getIt<GetHistoricalRatesUseCase>(),
      )..setCurrencies('USD', 'EUR'),
    ),
  ];
}

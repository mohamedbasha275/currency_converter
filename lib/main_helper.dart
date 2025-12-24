
// initializeApp
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/core/bloc_observer/bloc_observer.dart';
import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/features/home/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/features/home/presentation/manager/home_cubit.dart';
import 'package:currency_converter/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  Bloc.observer = MyBlocObserver();

}


// getStartWidget
Future<Widget> getStartWidget() async {
  //return const HomeScreen();
  // final AppPreferences appPreferences = getIt<AppPreferences>();
  // final bool isOnBoardingViewed = appPreferences.isOnBoardingScreenViewed();
  // if (isOnBoardingViewed) {
  //   // final bool isLogged = await appPreferences.isLogged();
  //   // return isLogged ? const HomeScreen() : const VisitorHomeScreen();
  //   return const HomeScreen();
  // } else {
  //   return const OnBoardingScreen();
  // }
  return const HomeScreen();
}

// mainProviders
mainProviders() {
  return [
    BlocProvider(create: (context) => HomeCubit(getCurrenciesUseCase: getIt<GetCurrenciesUseCase>())),
  ];
}

import 'package:currency_converter/common/bottom_navBar/models/navbar_model.dart';
import 'package:currency_converter/features/currency_converter/presentation/screens/currency_converter_screen.dart';
import 'package:currency_converter/features/currency_list/presentation/screens/currencies_screen.dart';
import 'package:currency_converter/features/historical_rates/presentation/screens/historical_rates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);

  int get currentIndex => state;

  final List<Widget> tabs = const [
    CurrencyConverterScreen(),
    CurrenciesScreen(),
    HistoricalRatesScreen(),
  ];

  final List<NavbarModel> navItems = const [
    NavbarModel(label: 'Convert', icon: Icons.swap_horiz_rounded),
    NavbarModel(label: 'Currencies', icon: Icons.monetization_on_outlined),
    NavbarModel(label: 'History', icon: Icons.trending_up_rounded),
  ];

  void changeIndex(int index) {
    emit(index);
  }
}

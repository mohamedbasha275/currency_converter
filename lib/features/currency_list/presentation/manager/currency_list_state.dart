part of 'currency_list_cubit.dart';

abstract class CurrencyListState {}

class CurrencyListInitial extends CurrencyListState {}

class CurrencyListLoading extends CurrencyListState {}

class CurrencyListLoaded extends CurrencyListState {
  final List<CurrencyListEntity> currencies;
  final List<CurrencyListEntity> filteredCurrencies;

  CurrencyListLoaded({
    required this.currencies,
    required this.filteredCurrencies,
  });

  bool get hasResults => filteredCurrencies.isNotEmpty;
}

class CurrencyListError extends CurrencyListState {
  final String message;

  CurrencyListError(this.message);
}

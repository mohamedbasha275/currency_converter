part of 'currency_converter_cubit.dart';

abstract class CurrencyConverterState {}

class CurrencyConverterInitial extends CurrencyConverterState {}

class CurrencyConverterLoading extends CurrencyConverterState {}

class CurrencyConverterLoaded extends CurrencyConverterState {
  final double rate;

  CurrencyConverterLoaded({required this.rate});
}

class CurrencyConverterError extends CurrencyConverterState {
  final String message;

  CurrencyConverterError(this.message);
}

class CurrencyConverterUpdated extends CurrencyConverterState {}

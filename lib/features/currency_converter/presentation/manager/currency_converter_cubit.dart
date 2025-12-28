import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';

part 'currency_converter_state.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState> {
  final ConvertCurrencyUseCase convertCurrencyUseCase;

  CurrencyConverterCubit({required this.convertCurrencyUseCase})
    : super(CurrencyConverterInitial()) {
    fromCurrency = CurrencyListEntity(code: 'USD', name: 'United States Dollar', symbol: '\$', flagUrl:
    '$flagSite${'us.png'}');
    toCurrency = CurrencyListEntity(code: 'EUR', name: 'Euro', symbol: '€', flagUrl:
    '$flagSite${'eu.png'}');
    amount = 100.0;
  }

  CurrencyListEntity? fromCurrency;
  CurrencyListEntity? toCurrency;
  double amount = 0.0;
  double? exchangeRate;

  void setFromCurrency(CurrencyListEntity currency) {
    fromCurrency = currency;
    exchangeRate = null;
    emit(CurrencyConverterUpdated());
  }

  void setToCurrency(CurrencyListEntity currency) {
    toCurrency = currency;
    exchangeRate = null;
    emit(CurrencyConverterUpdated());
  }

  void setAmount(double value) {
    amount = value;
    exchangeRate = null;
    emit(CurrencyConverterUpdated());
  }

  void swapCurrencies() {
    final temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    exchangeRate = null;
    emit(CurrencyConverterUpdated());
  }

  Future<void> convertCurrency() async {
    if (fromCurrency == null || toCurrency == null) {
      return;
    }
    emit(CurrencyConverterLoading());

    final result = await convertCurrencyUseCase.call(
      ConvertCurrencyParams(from: fromCurrency!.code, to: toCurrency!.code),
    );

    result.fold((failure) => emit(CurrencyConverterError(failure.message)), (
      rate,
    ) {
      exchangeRate = rate;
      emit(CurrencyConverterLoaded(rate: rate));
    });
  }

  double get convertedAmount {
    if (exchangeRate == null || amount == 0) return 0.0;
    return amount * exchangeRate!;
  }
}

import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/refresh_currencies_use_case.dart';

part 'currency_list_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  final GetCurrenciesUseCase getCurrenciesUseCase;
  final RefreshCurrenciesUseCase refreshCurrenciesUseCase;

  List<CurrencyListEntity> _allCurrencies = [];
  String _searchQuery = '';

  CurrencyListCubit({
    required this.getCurrenciesUseCase,
    required this.refreshCurrenciesUseCase,
  }) : super(CurrencyListInitial());

  Future<void> getCurrencies() async {
    emit(CurrencyListLoading());

    final result = await getCurrenciesUseCase.call();
    result.fold(
      (failure) => emit(CurrencyListError(failure.message)),
      (currencies) {
        _allCurrencies = currencies;
        emit(CurrencyListLoaded(
          currencies: currencies,
          filteredCurrencies: currencies,
        ));
      },
    );
  }

  void searchCurrencies(String query) {
    _searchQuery = query.trim().toLowerCase();
    
    if (state is CurrencyListLoaded) {
      if (_searchQuery.isEmpty) {
        emit(CurrencyListLoaded(
          currencies: _allCurrencies,
          filteredCurrencies: _allCurrencies,
        ));
      } else {
        final filtered = _allCurrencies.where((currency) {
          final code = currency.code.toLowerCase();
          final name = currency.name.toLowerCase();
          return code.contains(_searchQuery) || name.contains(_searchQuery);
        }).toList();
        
        emit(CurrencyListLoaded(
          currencies: _allCurrencies,
          filteredCurrencies: filtered,
        ));
      }
    }
  }

  void clearSearch() {
    _searchQuery = '';
    if (state is CurrencyListLoaded) {
      emit(CurrencyListLoaded(
        currencies: _allCurrencies,
        filteredCurrencies: _allCurrencies,
      ));
    }
  }

  /// Refresh currencies from API (clears local cache)
  Future<void> refreshCurrencies() async {
    emit(CurrencyListLoading());

    final result = await refreshCurrenciesUseCase.call();
    result.fold(
      (failure) => emit(CurrencyListError(failure.message)),
      (currencies) {
        _allCurrencies = currencies;
        emit(CurrencyListLoaded(
          currencies: currencies,
          filteredCurrencies: currencies,
        ));
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/home/domain/use_cases/get_currencies_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCurrenciesUseCase getCurrenciesUseCase;

  HomeCubit({
    required this.getCurrenciesUseCase,
  }) : super(HomeInitial());

  Future<void> getCurrencies() async {
    emit(HomeLoading());

    
    final result = await getCurrenciesUseCase.call();
    result.fold((failure) => emit(HomeError(failure.message)), (currencies) => emit(HomeLoaded(currencies: currencies)));
  }
}

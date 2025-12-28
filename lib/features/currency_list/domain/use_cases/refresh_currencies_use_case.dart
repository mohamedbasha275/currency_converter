import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/domain/repositories/currency_list_repository.dart';
import 'package:dartz/dartz.dart';

class RefreshCurrenciesUseCase extends UseCase<List<CurrencyListEntity>, NoParam> {
  final CurrencyListRepository repository;

  RefreshCurrenciesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CurrencyListEntity>>> call([NoParam? param]) async {
    return await repository.refreshCurrencies();
  }
}


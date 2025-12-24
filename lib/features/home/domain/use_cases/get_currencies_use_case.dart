import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';

class GetCurrenciesUseCase extends UseCase<List<CurrencyEntity>, NoParam> {
  final HomeRepository repository;

  GetCurrenciesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> call([NoParam? param]) async {
    return await repository.getCurrencies();
  }
}
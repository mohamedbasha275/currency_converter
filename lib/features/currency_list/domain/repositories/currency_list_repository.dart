import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyListRepository {
  Future<Either<Failure, List<CurrencyListEntity>>> getCurrencies();
  Future<Either<Failure, List<CurrencyListEntity>>> refreshCurrencies();
}

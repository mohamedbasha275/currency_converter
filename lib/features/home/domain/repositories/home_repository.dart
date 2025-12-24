import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:currency_converter/core/errors/failures.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();
}

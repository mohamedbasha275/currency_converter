import 'package:currency_converter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyConverterRepository {
  Future<Either<Failure, double>> convertCurrency(String from, String to);
}

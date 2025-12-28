import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/helper_functions/safe_api_call.dart';
import 'package:currency_converter/features/currency_converter/data/datasources/currency_converter_data_source.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:dartz/dartz.dart';

class CurrencyConverterRepositoryImpl implements CurrencyConverterRepository {
  final CurrencyConverterDataSource dataSource;

  CurrencyConverterRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, double>> convertCurrency(String from, String to) async {
    return safeApiCall(() => dataSource.convertCurrency(from, to));
  }
}

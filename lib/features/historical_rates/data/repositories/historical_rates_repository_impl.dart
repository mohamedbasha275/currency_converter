import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/helper_functions/safe_api_call.dart';
import 'package:currency_converter/features/historical_rates/data/datasources/historical_rates_data_source.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/domain/repositories/historical_rates_repository.dart';
import 'package:dartz/dartz.dart';

class HistoricalRatesRepositoryImpl implements HistoricalRatesRepository {
  final HistoricalRatesDataSource dataSource;

  HistoricalRatesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<HistoricalRateEntity>>> getHistoricalRates(
    String from,
    String to,
  ) async {
    return safeApiCall(() => dataSource.getHistoricalRates(from, to));
  }
}

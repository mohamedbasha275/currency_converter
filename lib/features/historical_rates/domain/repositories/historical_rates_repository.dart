import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HistoricalRatesRepository {
  Future<Either<Failure, List<HistoricalRateEntity>>> getHistoricalRates(
    String from,
    String to,
  );
}

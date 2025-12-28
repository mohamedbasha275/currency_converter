import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/domain/repositories/historical_rates_repository.dart';
import 'package:dartz/dartz.dart';

class GetHistoricalRatesParams {
  final String from;
  final String to;

  GetHistoricalRatesParams({required this.from, required this.to});
}

class GetHistoricalRatesUseCase
    extends UseCase<List<HistoricalRateEntity>, GetHistoricalRatesParams> {
  final HistoricalRatesRepository repository;

  GetHistoricalRatesUseCase(this.repository);

  @override
  Future<Either<Failure, List<HistoricalRateEntity>>> call([
    GetHistoricalRatesParams? param,
  ]) async {
    if (param == null) {
      return const Left(ServerFailure('Invalid parameters'));
    }
    return await repository.getHistoricalRates(param.from, param.to);
  }
}

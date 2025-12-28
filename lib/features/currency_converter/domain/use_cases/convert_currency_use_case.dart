import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:dartz/dartz.dart';

class ConvertCurrencyParams {
  final String from;
  final String to;

  const ConvertCurrencyParams({required this.from, required this.to});
}

class ConvertCurrencyUseCase extends UseCase<double, ConvertCurrencyParams> {
  final CurrencyConverterRepository repository;

  ConvertCurrencyUseCase(this.repository);

  @override
  Future<Either<Failure, double>> call([ConvertCurrencyParams? params]) async {
    if (params!.from.isEmpty ||params!.to.isEmpty ) {
      return const Left(ServerFailure('Invalid parameters'));
    }

    return repository.convertCurrency(params.from, params.to);
  }
}

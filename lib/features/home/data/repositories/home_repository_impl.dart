import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/helper_functions/safe_api_call.dart';
import 'package:currency_converter/features/home/data/datasources/home_data_source.dart';
import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});


  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() async {
    return safeApiCall(() => dataSource.getCurrencies());
  }
}

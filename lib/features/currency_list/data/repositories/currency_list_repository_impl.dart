import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/helper_functions/safe_api_call.dart';
import 'package:currency_converter/features/currency_list/data/datasources/currency_list_data_source.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/domain/repositories/currency_list_repository.dart';
import 'package:dartz/dartz.dart';

class CurrencyListRepositoryImpl implements CurrencyListRepository {
  final CurrencyListDataSource dataSource;

  CurrencyListRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CurrencyListEntity>>> getCurrencies() async {
    return safeApiCall(() => dataSource.getCurrencies());
  }

  @override
  Future<Either<Failure, List<CurrencyListEntity>>> refreshCurrencies() async {
    return safeApiCall(() async {
      await dataSource.clearLocalCache();
      return await dataSource.getCurrencies();
    });
  }
}

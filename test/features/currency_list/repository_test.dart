import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/features/currency_list/data/datasources/currency_list_data_source.dart';
import 'package:currency_converter/features/currency_list/data/repositories/currency_list_repository_impl.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyListDataSource extends Mock
    implements CurrencyListDataSource {}

void main() {
  late CurrencyListRepositoryImpl repository;
  late MockCurrencyListDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCurrencyListDataSource();
    repository = CurrencyListRepositoryImpl(mockDataSource);
  });

  group('getCurrencies', () {
    test('should return Right when data source succeeds', () async {
      final fakeCurrencies = [
        const CurrencyListEntity(
          code: 'USD',
          name: 'US Dollar',
          symbol: '\$',
          flagUrl: 'https://flagcdn.com/us.png',
        ),
        const CurrencyListEntity(
          code: 'EGY',
          name: 'Egyptian Pound',
          symbol: 'E£',
          flagUrl: 'https://flagcdn.com/eg.png',
        ),
      ];

      when(() => mockDataSource.getCurrencies())
          .thenAnswer((_) async => fakeCurrencies);

      final result = await repository.getCurrencies();

      expect(result, Right(fakeCurrencies));
      verify(() => mockDataSource.getCurrencies()).called(1);
    });

    test('should return Left when ServerException occurs', () async {
      when(() => mockDataSource.getCurrencies())
          .thenThrow(const ServerException('Error'));

      final result = await repository.getCurrencies();

      expect(result.isLeft(), true);
    });

    test('should return Left when no internet connection', () async {

      final dioError = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      );
      when(() => mockDataSource.getCurrencies()).thenThrow(dioError);
      final result = await repository.getCurrencies();
      expect(result.isLeft(), true);
    });
  });

  group('refreshCurrencies', () {

    test('should return Right when refresh succeeds', () async {

      final fakeCurrencies = [
        const CurrencyListEntity(
          code: 'USD',
          name: 'US Dollar',
          symbol: '\$',
          flagUrl: 'https://flagcdn.com/us.png',
        ),
      ];

      when(() => mockDataSource.clearLocalCache())
          .thenAnswer((_) async => {});
      when(() => mockDataSource.getCurrencies())
          .thenAnswer((_) async => fakeCurrencies);


      final result = await repository.refreshCurrencies();

      expect(result, Right(fakeCurrencies));
      verify(() => mockDataSource.clearLocalCache()).called(1);
      verify(() => mockDataSource.getCurrencies()).called(1);
    });

    test('should return Left when refresh fails', () async {

      when(() => mockDataSource.clearLocalCache())
          .thenAnswer((_) async => {});
      when(() => mockDataSource.getCurrencies())
          .thenThrow(const ServerException('Error'));

      final result = await repository.refreshCurrencies();

      expect(result.isLeft(), true);
    });
  });
}


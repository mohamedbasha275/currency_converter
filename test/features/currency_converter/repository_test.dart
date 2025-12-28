import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/features/currency_converter/data/datasources/currency_converter_data_source.dart';
import 'package:currency_converter/features/currency_converter/data/repositories/currency_converter_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterDataSource extends Mock
    implements CurrencyConverterDataSource {}

void main() {
  late CurrencyConverterRepositoryImpl repository;
  late MockCurrencyConverterDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCurrencyConverterDataSource();
    repository = CurrencyConverterRepositoryImpl(mockDataSource);
  });

  group('convertCurrency', () {
    // Define fallback values for the parameters
    test('should return Right when data source succeeds', () async {
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => 30.5);
      final result = await repository.convertCurrency('USD', 'EGY');
      expect(result, const Right(30.5));
    });
    // Define fallback values for the parameters
    test('should return Left when ServerException occurs', () async {
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenThrow(const ServerException('Error'));
      final result = await repository.convertCurrency('USD', 'EGY');
      expect(result.isLeft(), true);
    });
    // Define fallback values for the parameters
    test('should return Left when no internet connection', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      );
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenThrow(dioError);
      final result = await repository.convertCurrency('USD', 'EGY');
      expect(result.isLeft(), true);
    });
  });
}

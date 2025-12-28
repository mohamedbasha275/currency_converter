import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/errors/failures.dart';
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
    // ✅ Happy Path: data source نجح → Right(rate)
    test('should return Right when data source succeeds', () async {
      // Arrange
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => 30.5);

      // Act
      final result = await repository.convertCurrency('USD', 'EGY');

      // Assert
      expect(result, const Right(30.5));
    });

    // ❌ Error: ServerException → Left(ServerFailure)
    test('should return Left when ServerException occurs', () async {
      // Arrange
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenThrow(const ServerException('Error'));

      // Act
      final result = await repository.convertCurrency('USD', 'EGY');

      // Assert
      expect(result.isLeft(), true);
    });

    // ❌ Network Error: مفيش نت → Left(ServerFailure)
    test('should return Left when no internet connection', () async {
      // Arrange
      final dioError = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionError,
      );
      when(() => mockDataSource.convertCurrency('USD', 'EGY'))
          .thenThrow(dioError);

      // Act
      final result = await repository.convertCurrency('USD', 'EGY');

      // Assert
      expect(result.isLeft(), true);
    });
  });
}

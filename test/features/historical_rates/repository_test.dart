import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/historical_rates/data/datasources/historical_rates_data_source.dart';
import 'package:currency_converter/features/historical_rates/data/models/historical_rate_model.dart';
import 'package:currency_converter/features/historical_rates/data/repositories/historical_rates_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoricalRatesDataSource extends Mock
    implements HistoricalRatesDataSource {}

void main() {
  late HistoricalRatesRepositoryImpl repository;
  late MockHistoricalRatesDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockHistoricalRatesDataSource();
    repository = HistoricalRatesRepositoryImpl(mockDataSource);
  });

  group('getHistoricalRates', () {
    // ✅ Happy Path: data source نجح → Right(rates)
    test('should return Right when data source succeeds', () async {
      // Arrange
      final fakeRates = [
        HistoricalRateModel(rate: 30.5, date: DateTime(2024, 1, 1)),
        HistoricalRateModel(rate: 30.7, date: DateTime(2024, 1, 2)),
      ];

      when(() => mockDataSource.getHistoricalRates('USD', 'EGY'))
          .thenAnswer((_) async => fakeRates);

      // Act
      final result = await repository.getHistoricalRates('USD', 'EGY');

      // Assert
      expect(result, Right(fakeRates));
      verify(() => mockDataSource.getHistoricalRates('USD', 'EGY')).called(1);
    });

    // ❌ Error: ServerException → Left(ServerFailure)
    test('should return Left when ServerException occurs', () async {
      // Arrange
      when(() => mockDataSource.getHistoricalRates('USD', 'EGY'))
          .thenThrow(const ServerException('Error'));

      // Act
      final result = await repository.getHistoricalRates('USD', 'EGY');

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
      when(() => mockDataSource.getHistoricalRates('USD', 'EGY'))
          .thenThrow(dioError);

      // Act
      final result = await repository.getHistoricalRates('USD', 'EGY');

      // Assert
      expect(result.isLeft(), true);
    });
  });
}


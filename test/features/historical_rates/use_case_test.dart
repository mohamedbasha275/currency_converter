import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/domain/repositories/historical_rates_repository.dart';
import 'package:currency_converter/features/historical_rates/domain/use_cases/get_historical_rates_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoricalRatesRepository extends Mock
    implements HistoricalRatesRepository {}

void main() {
  late GetHistoricalRatesUseCase useCase;
  late MockHistoricalRatesRepository mockRepository;

  setUp(() {
    mockRepository = MockHistoricalRatesRepository();
    useCase = GetHistoricalRatesUseCase(mockRepository);
  });

  group('GetHistoricalRatesUseCase', () {
    test('should return rates when repository succeeds', () async {
      // Arrange
      final fakeRates = [
        HistoricalRateEntity(
          rate: 30.5,
          date: DateTime(2024, 1, 1),
        ),
        HistoricalRateEntity(
          rate: 30.7,
          date: DateTime(2024, 1, 2),
        ),
      ];

      when(() => mockRepository.getHistoricalRates('USD', 'EGY'))
          .thenAnswer((_) async => Right(fakeRates));

      final params = GetHistoricalRatesParams(from: 'USD', to: 'EGY');
      final result = await useCase.call(params);

      expect(result, Right(fakeRates));
      verify(() => mockRepository.getHistoricalRates('USD', 'EGY')).called(1);
    });

    test('should return error when params is null', () async {

      final result = await useCase.call(null);

      expect(result, const Left(ServerFailure('Invalid parameters')));
      verifyNever(() => mockRepository.getHistoricalRates(any(), any()));
    });

    test('should pass through error from repository', () async {
      when(() => mockRepository.getHistoricalRates('USD', 'EGY'))
          .thenAnswer((_) async => const Left(ServerFailure('Network error')));

      final params = GetHistoricalRatesParams(from: 'USD', to: 'EGY');
      final result = await useCase.call(params);

      expect(result, const Left(ServerFailure('Network error')));
    });
  });
}


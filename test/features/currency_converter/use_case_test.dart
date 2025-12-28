import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRepository extends Mock
    implements CurrencyConverterRepository {}

void main() {
  late ConvertCurrencyUseCase useCase;
  late MockCurrencyConverterRepository mockRepository;

  setUp(() {
    mockRepository = MockCurrencyConverterRepository();
    useCase = ConvertCurrencyUseCase(mockRepository);
  });

  group('ConvertCurrencyUseCase', () {
    // ✅ Happy Path: parameters صحيحة → Right(rate)
    test('should return Right when parameters are valid', () async {
      // Arrange
      const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
      when(() => mockRepository.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => const Right(30.5));

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result, const Right(30.5));
    });

    // 🛡️ Validation: from فاضي → Error
    test('should return error when from is empty', () async {
      // Arrange
      const params = ConvertCurrencyParams(from: '', to: 'EGY');

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result, const Left(ServerFailure('Invalid parameters')));
    });

    // ❌ Error: repository فشل → يمرر الـ error
    test('should pass through error from repository', () async {
      // Arrange
      const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
      when(() => mockRepository.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => const Left(ServerFailure('Network error')));

      // Act
      final result = await useCase.call(params);

      // Assert
      expect(result, const Left(ServerFailure('Network error')));
    });
  });
}

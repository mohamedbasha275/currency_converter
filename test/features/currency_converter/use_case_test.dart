import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/currency_converter/domain/repositories/currency_converter_repository.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRepository extends Mock implements CurrencyConverterRepository {}

void main() {
  late ConvertCurrencyUseCase useCase;
  late MockCurrencyConverterRepository mockRepository;

  setUp(() {
    mockRepository = MockCurrencyConverterRepository();
    useCase = ConvertCurrencyUseCase(mockRepository);
  });

  group('ConvertCurrencyUseCase', () {
    // test for valid parameters
    test('should return Right when parameters are valid', () async {
      const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
      when(() => mockRepository.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => const Right(30.5));
      final result = await useCase.call(params);
      expect(result, const Right(30.5));
    });
    // test for empty from parameter
    test('should return error when from is empty', () async {
      const params = ConvertCurrencyParams(from: '', to: 'EGY');
      final result = await useCase.call(params);
      expect(result, const Left(ServerFailure('Invalid parameters')));
    });
    // test for empty to parameter
    test('should pass through error from repository', () async {
      const params = ConvertCurrencyParams(from: 'USD', to: 'EGY');
      when(() => mockRepository.convertCurrency('USD', 'EGY'))
          .thenAnswer((_) async => const Left(ServerFailure('Network error')));
      final result = await useCase.call(params);
      expect(result, const Left(ServerFailure('Network error')));
    });
  });
}

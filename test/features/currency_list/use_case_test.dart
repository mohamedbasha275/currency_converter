import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/domain/repositories/currency_list_repository.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/get_currencies_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyListRepository extends Mock
    implements CurrencyListRepository {}

void main() {
  late GetCurrenciesUseCase useCase;
  late MockCurrencyListRepository mockRepository;

  setUp(() {
    mockRepository = MockCurrencyListRepository();
    useCase = GetCurrenciesUseCase(mockRepository);
  });

  group('GetCurrenciesUseCase', () {
    test('should return currencies when repository succeeds', () async {
      // Arrange
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

      when(() => mockRepository.getCurrencies())
          .thenAnswer((_) async => Right(fakeCurrencies));

      final result = await useCase.call();

      expect(result, Right(fakeCurrencies));
      verify(() => mockRepository.getCurrencies()).called(1);
    });

    test('should pass through error from repository', () async {
      when(() => mockRepository.getCurrencies())
          .thenAnswer((_) async => const Left(ServerFailure('Network error')));
      final result = await useCase.call();
      expect(result, const Left(ServerFailure('Network error')));
    });
  });
}


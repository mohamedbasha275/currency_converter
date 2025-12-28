import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/currency_converter/domain/use_cases/convert_currency_use_case.dart';
import 'package:currency_converter/features/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConvertCurrencyUseCase extends Mock
    implements ConvertCurrencyUseCase {}

void main() {
  late CurrencyConverterCubit cubit;
  late MockConvertCurrencyUseCase mockUseCase;

  final usdCurrency = CurrencyListEntity(
    code: 'USD',
    name: 'US Dollar',
    symbol: '\$',
    flagUrl: 'https://flagcdn.com/us.png',
  );

  final egyCurrency = CurrencyListEntity(
    code: 'EGY',
    name: 'Egyptian Pound',
    symbol: 'E£',
    flagUrl: 'https://flagcdn.com/eg.png',
  );

  setUpAll(() {
    registerFallbackValue(
      const ConvertCurrencyParams(from: 'USD', to: 'EGY'),
    );
  });

  setUp(() {
    mockUseCase = MockConvertCurrencyUseCase();
    cubit = CurrencyConverterCubit(convertCurrencyUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('Initial State', () {
    test('should start with Initial state', () {
      expect(cubit.state, isA<CurrencyConverterInitial>());
    });
  });

  group('convertCurrency', () {
    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should emit Loading then Loaded on success',
      build: () {
        cubit.setFromCurrency(usdCurrency);
        cubit.setToCurrency(egyCurrency);
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => const Right(30.5));
        return cubit;
      },
      act: (cubit) => cubit.convertCurrency(),
      expect: () => [
        isA<CurrencyConverterLoading>(),
        isA<CurrencyConverterLoaded>().having((s) => s.rate, 'rate', 30.5),
      ],
    );

    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should emit Loading then Error on failure',
      build: () {
        cubit.setFromCurrency(usdCurrency);
        cubit.setToCurrency(egyCurrency);
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));
        return cubit;
      },
      act: (cubit) => cubit.convertCurrency(),
      expect: () => [
        isA<CurrencyConverterLoading>(),
        isA<CurrencyConverterError>()
            .having((s) => s.message, 'message', 'Network error'),
      ],
    );

    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should calculate converted amount correctly',
      build: () {
        cubit.setFromCurrency(usdCurrency);
        cubit.setToCurrency(egyCurrency);
        cubit.setAmount(100.0);
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => const Right(30.5));
        return cubit;
      },
      act: (cubit) => cubit.convertCurrency(),
      verify: (_) {
        expect(cubit.convertedAmount, 3050.0);
      },
    );
  });

  group('State Updates', () {
    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should update currencies',
      build: () => cubit,
      act: (cubit) {
        cubit.setFromCurrency(usdCurrency);
        cubit.setToCurrency(egyCurrency);
      },
      expect: () => [
        isA<CurrencyConverterUpdated>(),
        isA<CurrencyConverterUpdated>(),
      ],
    );

    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should update amount',
      build: () => cubit,
      act: (cubit) => cubit.setAmount(500.0),
      verify: (_) {
        expect(cubit.amount, 500.0);
      },
    );

    blocTest<CurrencyConverterCubit, CurrencyConverterState>(
      'should swap currencies',
      build: () => cubit,
      seed: () {
        cubit.fromCurrency = usdCurrency;
        cubit.toCurrency = egyCurrency;
        return CurrencyConverterInitial();
      },
      act: (cubit) => cubit.swapCurrencies(),
      verify: (_) {
        expect(cubit.fromCurrency?.code, 'EGY');
        expect(cubit.toCurrency?.code, 'USD');
      },
    );
  });

  group('convertedAmount Getter', () {
    test('should calculate amount times rate', () {
      cubit.amount = 100.0;
      cubit.exchangeRate = 30.5;

      expect(cubit.convertedAmount, 3050.0);
    });

    test('should return 0 when rate is null', () {
      cubit.amount = 100.0;
      cubit.exchangeRate = null;

      expect(cubit.convertedAmount, 0.0);
    });
  });
}

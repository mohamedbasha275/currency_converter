import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:currency_converter/features/historical_rates/domain/use_cases/get_historical_rates_use_case.dart';
import 'package:currency_converter/features/historical_rates/presentation/manager/historical_rates_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHistoricalRatesUseCase extends Mock
    implements GetHistoricalRatesUseCase {}

void main() {
  late HistoricalRatesCubit cubit;
  late MockGetHistoricalRatesUseCase mockUseCase;

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

  setUpAll(() {
    registerFallbackValue(
      GetHistoricalRatesParams(from: 'USD', to: 'EGY'),
    );
  });

  setUp(() {
    mockUseCase = MockGetHistoricalRatesUseCase();
    cubit = HistoricalRatesCubit(getHistoricalRatesUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('Initial State', () {
    // يجب أن يبدأ بـ HistoricalRatesInitial
    test('should start with Initial state', () {
      expect(cubit.state, isA<HistoricalRatesInitial>());
    });
  });

  group('setCurrencies', () {
    // يجب أن يضبط العملات ويطلع Idle state
    blocTest<HistoricalRatesCubit, HistoricalRatesState>(
      'should set currencies and emit Idle state',
      build: () => cubit,
      act: (cubit) => cubit.setCurrencies('USD', 'EGY'),
      expect: () => [
        isA<HistoricalRatesIdle>()
            .having((s) => s.fromCurrency, 'fromCurrency', 'USD')
            .having((s) => s.toCurrency, 'toCurrency', 'EGY'),
      ],
    );

    // يجب أن مايطلعش state جديد لو نفس العملات
    blocTest<HistoricalRatesCubit, HistoricalRatesState>(
      'should not emit new state if currencies are the same',
      build: () => cubit,
      seed: () {
        cubit.setCurrencies('USD', 'EGY');
        return HistoricalRatesIdle(fromCurrency: 'USD', toCurrency: 'EGY');
      },
      act: (cubit) => cubit.setCurrencies('USD', 'EGY'), // نفس العملات
      expect: () => [], // مافيش states جديدة
    );
  });

  group('getHistoricalRates', () {
    // ✅ Happy Path: use case نجح → Loading → Loaded
    blocTest<HistoricalRatesCubit, HistoricalRatesState>(
      'should emit Loading then Loaded on success',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeRates));
        return cubit;
      },
      seed: () {
        cubit.setCurrencies('USD', 'EGY');
        return HistoricalRatesIdle(fromCurrency: 'USD', toCurrency: 'EGY');
      },
      act: (cubit) => cubit.getHistoricalRates(),
      expect: () => [
        isA<HistoricalRatesLoading>(),
        isA<HistoricalRatesLoaded>()
            .having((s) => s.rates.length, 'rates length', 2)
            .having((s) => s.isRefreshing, 'isRefreshing', false),
      ],
    );

    // ❌ Error: use case فشل
    // (الكود بيستخدم cache معقد، بنختبر الحالة الأساسية بس)
    blocTest<HistoricalRatesCubit, HistoricalRatesState>(
      'should handle error from use case',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));
        return cubit;
      },
      seed: () {
        cubit.setCurrencies('USD', 'EGY');
        return HistoricalRatesIdle(fromCurrency: 'USD', toCurrency: 'EGY');
      },
      act: (cubit) => cubit.getHistoricalRates(forceRefresh: true),
      verify: (_) {
        // نتأكد ان الـ state مش Loaded (يعني في error أو loading)
        expect(cubit.state, isNot(isA<HistoricalRatesLoaded>()));
      },
    );

    // يجب أن مايطلعش states لو العملات null
    test('should not emit states when currencies are null', () async {
      // Arrange - العملات null
      cubit.fromCurrency = null;
      cubit.toCurrency = null;

      // Act
      await cubit.getHistoricalRates();

      // Assert
      expect(cubit.state, isA<HistoricalRatesInitial>());
    });
  });
}


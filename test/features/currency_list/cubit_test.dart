import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/use_cases/use_case.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/get_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/domain/use_cases/refresh_currencies_use_case.dart';
import 'package:currency_converter/features/currency_list/presentation/manager/currency_list_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}
class MockRefreshCurrenciesUseCase extends Mock implements RefreshCurrenciesUseCase {}

void main() {
  late CurrencyListCubit cubit;
  late MockGetCurrenciesUseCase mockGetCurrenciesUseCase;
  late MockRefreshCurrenciesUseCase mockRefreshCurrenciesUseCase;

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
    const CurrencyListEntity(
      code: 'EUR',
      name: 'Euro',
      symbol: '€',
      flagUrl: 'https://flagcdn.com/eu.png',
    ),
  ];

  setUpAll(() {
    registerFallbackValue(NoParam());
  });

  setUp(() {
    mockGetCurrenciesUseCase = MockGetCurrenciesUseCase();
    mockRefreshCurrenciesUseCase = MockRefreshCurrenciesUseCase();
    cubit = CurrencyListCubit(
      getCurrenciesUseCase: mockGetCurrenciesUseCase,
      refreshCurrenciesUseCase: mockRefreshCurrenciesUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('Initial State', () {
    // يجب أن يبدأ بـ CurrencyListInitial
    test('should start with Initial state', () {
      expect(cubit.state, isA<CurrencyListInitial>());
    });
  });

  group('getCurrencies', () {
    // ✅ Happy Path: use case نجح → Loading → Loaded
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should emit Loading then Loaded on success',
      build: () {
        when(() => mockGetCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeCurrencies));
        return cubit;
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListLoaded>()
            .having((s) => s.currencies.length, 'currencies length', 3)
            .having((s) => s.filteredCurrencies.length, 'filtered length', 3),
      ],
    );

    // ❌ Error: use case فشل → Loading → Error
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should emit Loading then Error on failure',
      build: () {
        when(() => mockGetCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));
        return cubit;
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListError>()
            .having((s) => s.message, 'message', 'Network error'),
      ],
    );
  });

  group('searchCurrencies', () {
    // يجب أن يفلتر العملات حسب الـ query
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should filter currencies by search query',
      build: () {
        when(() => mockGetCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeCurrencies));
        return cubit;
      },
      seed: () => CurrencyListInitial(),
      act: (cubit) async {
        await cubit.getCurrencies(); // نجيب العملات أولاً
        cubit.searchCurrencies('USD'); // نبحث عن USD
      },
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListLoaded>(),
        isA<CurrencyListLoaded>()
            .having((s) => s.filteredCurrencies.length, 'filtered length', 1)
            .having((s) => s.filteredCurrencies.first.code, 'first code', 'USD'),
      ],
    );

    // يجب أن يرجع كل العملات لو query فاضي
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should return all currencies when query is empty',
      build: () {
        when(() => mockGetCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeCurrencies));
        return cubit;
      },
      seed: () => CurrencyListInitial(),
      act: (cubit) async {
        await cubit.getCurrencies();
        cubit.searchCurrencies('USD');
        cubit.searchCurrencies(''); // query فاضي
      },
      verify: (_) {
        final state = cubit.state as CurrencyListLoaded;
        expect(state.filteredCurrencies.length, 3); // كل العملات
      },
    );
  });

  group('refreshCurrencies', () {
    // ✅ Happy Path: refresh نجح
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should emit Loading then Loaded on refresh success',
      build: () {
        when(() => mockRefreshCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => Right(fakeCurrencies));
        return cubit;
      },
      act: (cubit) => cubit.refreshCurrencies(),
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListLoaded>(),
      ],
    );

    // ❌ Error: refresh فشل
    blocTest<CurrencyListCubit, CurrencyListState>(
      'should emit Loading then Error on refresh failure',
      build: () {
        when(() => mockRefreshCurrenciesUseCase.call(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Network error')));
        return cubit;
      },
      act: (cubit) => cubit.refreshCurrencies(),
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListError>(),
      ],
    );
  });
}


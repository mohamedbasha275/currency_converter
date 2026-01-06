import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:currency_converter/features/currency_list/data/datasources/currency_list_data_source.dart';
import 'package:currency_converter/features/currency_list/data/helper/currency_database_helper.dart';
import 'package:currency_converter/features/currency_list/data/models/currency_list_model.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}
class MockCurrencyDatabaseHelper extends Mock implements CurrencyDatabaseHelper {}

void main() {
  late CurrencyListDataSourceImpl dataSource;
  late MockApiService mockApiService;
  late MockCurrencyDatabaseHelper mockDatabaseHelper;

  setUpAll(() {
    registerFallbackValue(Endpoint.getCurrencies);
  });

  setUp(() {
    mockApiService = MockApiService();
    mockDatabaseHelper = MockCurrencyDatabaseHelper();
    dataSource = CurrencyListDataSourceImpl(mockApiService, mockDatabaseHelper);
  });

  group('getCurrencies', () {
    test('should return currencies from API when no cache', () async {
      final fakeResponse = {
        'symbols': {
          'USD': 'US Dollar',
          'EGY': 'Egyptian Pound',
        }
      };

      when(() => mockDatabaseHelper.hasCurrencies())
          .thenAnswer((_) async => false);
      when(() => mockApiService.get(endpoint: Endpoint.getCurrencies))
          .thenAnswer((_) async => fakeResponse);
      when(() => mockDatabaseHelper.insertCurrencies(any()))
          .thenAnswer((_) async => {});

      final result = await dataSource.getCurrencies();
      expect(result.length, 2);
      expect(result.any((c) => c.code == 'USD'), true);
      expect(result.any((c) => c.code == 'EGY'), true);
      verify(() => mockDatabaseHelper.hasCurrencies()).called(1);
      verify(() => mockApiService.get(endpoint: Endpoint.getCurrencies)).called(1);
    });

    test('should return currencies from cache when available', () async {
      final cachedCurrencies = [
        CurrencyListModel.fromJson({
          'code': 'USD',
          'name': 'US Dollar',
          'symbol': '\$',
          'flagUrl': 'https://flagcdn.com/us.png',
        }),
      ];

      when(() => mockDatabaseHelper.hasCurrencies())
          .thenAnswer((_) async => true);
      when(() => mockDatabaseHelper.getCurrencies())
          .thenAnswer((_) async => cachedCurrencies);

      final result = await dataSource.getCurrencies();

      expect(result.length, 1);
      expect(result.first.code, 'USD');
      verify(() => mockDatabaseHelper.hasCurrencies()).called(1);
      verify(() => mockDatabaseHelper.getCurrencies()).called(1);
    });
  });

  group('clearLocalCache', () {
    test('should clear local cache', () async {
      when(() => mockDatabaseHelper.clearCurrencies())
          .thenAnswer((_) async => Future.value());
      await dataSource.clearLocalCache();
      verify(() => mockDatabaseHelper.clearCurrencies()).called(1);
    });
  });
}


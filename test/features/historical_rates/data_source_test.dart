import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:currency_converter/features/historical_rates/data/datasources/historical_rates_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late HistoricalRatesDataSourceImpl dataSource;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    dataSource = HistoricalRatesDataSourceImpl(mockApiService);
  });

  group('getHistoricalRates', () {
    test('should return rates when API succeeds', () async {
      // Arrange
      final fakeResponse = {
        'results': {
          'USD': {
            '2024-01-01': 30.5,
            '2024-01-02': 30.7,
          }
        }
      };

      when(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).thenAnswer((_) async => fakeResponse);


      final result = await dataSource.getHistoricalRates('USD', 'EGY');

      expect(result.length, 2);
      expect(result.first.rate, 30.5);
      verify(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).called(1);
    });

    test('should throw exception when results are empty', () async {
      final fakeResponse = <String, dynamic>{};
      when(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).thenAnswer((_) async => fakeResponse);

      expect(
        () => dataSource.getHistoricalRates('USD', 'EGY'),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw exception when rates list is empty', () async {
      final fakeResponse = {
        'results': <String, dynamic>{}
      };

      when(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).thenAnswer((_) async => fakeResponse);

      expect(
        () => dataSource.getHistoricalRates('USD', 'EGY'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}


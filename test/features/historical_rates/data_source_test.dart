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
        "rates": {
          "2025-12-26": {
            "EGP": 47.553819
          },
          "2025-12-27": {
            "EGP": 47.553819
          },
          "2025-12-28": {
            "EGP": 47.569776
          },
          "2025-12-29": {
            "EGP": 47.556646
          }
        }
      };

      when(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).thenAnswer((_) async => fakeResponse);


      final result = await dataSource.getHistoricalRates('USD', 'EGP');

      expect(result.length, 4);
      expect(result.first.rate, 47.553819);
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
        () => dataSource.getHistoricalRates('USD', 'EGP'),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw exception when rates list is empty', () async {
      final fakeResponse = {
        'rates': <String, dynamic>{}
      };

      when(() => mockApiService.get(
            endpoint: Endpoint.getCurrenciesHistory,
            parameter: any(named: 'parameter'),
          )).thenAnswer((_) async => fakeResponse);

      expect(
        () => dataSource.getHistoricalRates('USD', 'EGP'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}


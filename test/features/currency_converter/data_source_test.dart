import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:currency_converter/features/currency_converter/data/datasources/currency_converter_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late CurrencyConverterDataSourceImpl dataSource;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    dataSource = CurrencyConverterDataSourceImpl(mockApiService);
  });

  // when API succeeds
  group('convertCurrency', () {
    test('should return rate when API succeeds', () async {
      final fakeResponse = {
        'rates': {'EGP': 30.5},
      };
      when(
        () => mockApiService.get(
          endpoint: Endpoint.convertCurrency,
          parameter: '&symbols=EGP&base=USD',
        ),
      ).thenAnswer((_) async => fakeResponse);
      final result = await dataSource.convertCurrency('USD', 'EGP');
      expect(result, 30.5);
    });
    //  when rate is null
    test('should throw exception when rate is null', () async {
      final fakeResponse = {
        'rates': {'EGP': null},
      };
      when(
        () => mockApiService.get(
          endpoint: Endpoint.convertCurrency,
          parameter: '&symbols=EGP&base=USD',
        ),
      ).thenAnswer((_) async => fakeResponse);
      expect(
        () => dataSource.convertCurrency('USD', 'EGP'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}

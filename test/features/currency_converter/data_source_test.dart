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

  group('convertCurrency', () {
    // ✅ Happy Path: يرجع rate صحيح
    // مثال: API رجع {"result": {"EGY": 30.5}} → يرجع 30.5
    test('should return rate when API succeeds', () async {
      // Arrange
      final fakeResponse = {
        'result': {'EGY': 30.5}
      };
      when(() => mockApiService.get(
            endpoint: Endpoint.convertCurrency,
            parameter: '&from=USD&to=EGY',
          )).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await dataSource.convertCurrency('USD', 'EGY');

      // Assert
      expect(result, 30.5);
    });

    // ❌ Error: لما rate يكون null
    test('should throw exception when rate is null', () async {
      // Arrange
      final fakeResponse = {
        'result': {'EGY': null}
      };
      when(() => mockApiService.get(
            endpoint: Endpoint.convertCurrency,
            parameter: '&from=USD&to=EGY',
          )).thenAnswer((_) async => fakeResponse);

      // Act & Assert
      expect(
        () => dataSource.convertCurrency('USD', 'EGY'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}

import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';

abstract class CurrencyConverterDataSource {
  Future<double> convertCurrency(String from, String to);
}

class CurrencyConverterDataSourceImpl implements CurrencyConverterDataSource {
  final ApiService apiService;

  CurrencyConverterDataSourceImpl(this.apiService);

  @override
  Future<double> convertCurrency(String from, String to) async {
    String parameter = '&symbols=$to&base=$from';
    final response = await apiService.get(
      endpoint: Endpoint.convertCurrency,
      parameter: parameter,
    );
    final rates = response['rates'] as Map<String, dynamic>?;
    if (rates == null || rates.isEmpty) {
      throw const ServerException('Conversion rate not found');
    }
    final rate = rates[to];
    if (rate == null) {
      throw const ServerException('Conversion rate not found');
    }
    return (rate as num).toDouble();
  }
}

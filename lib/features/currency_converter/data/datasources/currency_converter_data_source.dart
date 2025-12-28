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
    String parameter = '&from=$from&to=$to';
    final response = await apiService.get(
      endpoint: Endpoint.convertCurrency,
      parameter: parameter,
    );
    final fromMap = response['result'] as Map<String, dynamic>;
    final rateValue = fromMap.values.first;
    final rate = rateValue;
    if (rate == null) {
      throw const ServerException('Conversion rate not found');
    }
    return rate.toDouble();
  }
}

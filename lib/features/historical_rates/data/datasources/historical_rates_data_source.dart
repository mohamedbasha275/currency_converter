import 'package:currency_converter/core/errors/exceptions.dart';
import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:currency_converter/features/historical_rates/data/models/historical_rate_model.dart';

abstract class HistoricalRatesDataSource {
  Future<List<HistoricalRateModel>> getHistoricalRates(String from, String to);
}

class HistoricalRatesDataSourceImpl implements HistoricalRatesDataSource {
  final ApiService apiService;

  HistoricalRatesDataSourceImpl(this.apiService);

  @override
  Future<List<HistoricalRateModel>> getHistoricalRates(
    String from,
    String to,
  ) async { 
    final today = DateTime.now().toUtc();
    final endDate = DateTime.utc(today.year, today.month, today.day);
    final startDate = endDate.subtract(const Duration(days: 7));
    
    final startStr = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final endStr = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
    
    // FastForex time-series uses: from (base), to (target), start_date, end_date
    final parameter = '&start_date=$startStr&end_date=$endStr&base=$from&symbols=$to';

    final response = await apiService.get(
      endpoint: Endpoint.getCurrenciesHistory,
      parameter: parameter,
    );
    final results = response['rates'] as Map<String, dynamic>?;
    if (results == null || results.isEmpty) {
      throw const ServerException('No historical rates data available');
    }
    final rates = <HistoricalRateModel>[];
    results.forEach((dateStr, value) {
      if (value is Map<String, dynamic>) {
        final rateValue = value[to];
        if (rateValue != null) {
          rates.add(
            HistoricalRateModel(
              date: DateTime.parse(dateStr),
              rate: (rateValue as num).toDouble(),
            ),
          );
        }
      }
    });

    if (rates.isEmpty) {
      throw ServerException('No historical rates data found for $from to $to');
    }
    return rates;
  }
}



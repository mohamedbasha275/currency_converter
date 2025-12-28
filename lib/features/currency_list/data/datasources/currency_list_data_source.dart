import 'package:currency_converter/core/navigation/api_service.dart';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:currency_converter/features/currency_list/data/helper/currency_data.dart';
import 'package:currency_converter/features/currency_list/data/helper/currency_database_helper.dart';
import 'package:currency_converter/features/currency_list/data/models/currency_list_model.dart';
import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';

abstract class CurrencyListDataSource {
  Future<List<CurrencyListEntity>> getCurrencies();
  Future<void> clearLocalCache();
}

class CurrencyListDataSourceImpl implements CurrencyListDataSource {
  final ApiService apiService;
  final CurrencyDatabaseHelper databaseHelper;
  CurrencyListDataSourceImpl(this.apiService, this.databaseHelper);

  @override
  Future<List<CurrencyListEntity>> getCurrencies() async {

    final hasCached = await databaseHelper.hasCurrencies();
    if (hasCached) {
      final cachedCurrencies = await databaseHelper.getCurrencies();
      return cachedCurrencies;
    }

    final response = await apiService.get(endpoint: Endpoint.getCurrencies);
    final currenciesMap = response['currencies'] as Map<String, dynamic>;
    final currencies = currenciesMap.entries.map((entry) {
      final code = entry.key;
      final name = entry.value as String;
      return CurrencyListModel.fromJson(
        {
          'code': code,
          'name': name,
          'symbol': CurrencyData.symbolByCurrency[code] ?? '',
          'flagUrl':
          '$flagSite${CurrencyData.countryCode(code).toLowerCase()}.png',
        }
      );
    }).toList();
    await databaseHelper.insertCurrencies(currencies);
    return currencies;
  }

  @override
  Future<void> clearLocalCache() async {
    await databaseHelper.clearCurrencies();
  }
}


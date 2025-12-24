import 'package:currency_converter/core/dio/api_service.dart';
import 'package:currency_converter/core/dio/end_points.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';

abstract class HomeDataSource {
  Future<List<CurrencyEntity>> getCurrencies();
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiService apiService;

  HomeDataSourceImpl(this.apiService);

  @override
  Future<List<CurrencyEntity>> getCurrencies() async {
    final data = await apiService.get(endpoint: Endpoint.getStores);
    final List items = data['data']['categories'];
    return items
        .map((item) => CurrencyModel.fromJson(item))
        .toList();
  }

}

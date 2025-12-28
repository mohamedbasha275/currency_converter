import 'package:currency_converter/features/currency_list/domain/entities/currency_list_entity.dart';

class CurrencyListModel extends CurrencyListEntity {
  const CurrencyListModel({
    required super.code,
    required super.name,
    required super.symbol,
    required super.flagUrl,
  });

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) {
    return CurrencyListModel(
      code: json['code'],
      name: json['name'],
      symbol: json['symbol'],
      flagUrl: json['flagUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'symbol': symbol,
      'flagUrl': flagUrl,
    };
  }
}

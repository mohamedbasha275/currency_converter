import 'package:currency_converter/features/home/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    required super.id,
    required super.name,
    required super.icon,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
      id: json['id'],
      name: json['name'] as String,
      icon: json['icon'],
    );
}

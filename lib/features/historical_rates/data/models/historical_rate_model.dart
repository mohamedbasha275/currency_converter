import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';

class HistoricalRateModel extends HistoricalRateEntity {
  const HistoricalRateModel({required super.rate, required super.date});

  factory HistoricalRateModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final dateStr = json['date'] as String;
    final date = DateTime.parse(dateStr);
    final rate = (json['rate'] as num).toDouble();
    
    return HistoricalRateModel(rate: rate, date: date);
  }
}

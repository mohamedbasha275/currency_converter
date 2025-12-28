import 'package:intl/intl.dart';

class HistoricalRateEntity {
  final double rate;
  final DateTime date;
  final double deltaPct;

  const HistoricalRateEntity({
    required this.rate,
    required this.date,
    this.deltaPct = 0.0,
  });

  /// Check if the date is today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Get day name
  String get dayName {
    if (isToday) return 'Today';
    return DateFormat('EEE').format(date);
  }

  /// Get formatted date
  String get formattedDate {
    return DateFormat('MMM dd').format(date);
  }

  /// Get formatted date for chart
  String get chartDateLabel {
    return DateFormat('dd MMM').format(date);
  }

  /// Format the rate with 4 decimal places
  String get formattedRate {
    return rate.toStringAsFixed(4);
  }

  /// Calculate daily percentage change compared to previous rate
  double calculateDailyChange(HistoricalRateEntity? previousRate) {
    if (previousRate == null || previousRate.rate == 0) return 0.0;
    return ((rate - previousRate.rate) / previousRate.rate) * 100;
  }

  /// Format daily change with sign and percentage
  String formatDailyChange(double changePct) {
    final prefix = changePct >= 0 ? '+' : '';
    return '$prefix${changePct.toStringAsFixed(1)}%';
  }
}

extension HistoricalRateListExtension on List<HistoricalRateEntity> {
  /// Calculate percentage change between first and last rate
  double get overallPercentageChange {
    if (length < 2 || first.rate == 0) return 0.0;
    return ((last.rate - first.rate) / first.rate) * 100;
  }
  /// Get the current (latest) rate
  double get currentRate {
    return isEmpty ? 0.0 : last.rate;
  }
}





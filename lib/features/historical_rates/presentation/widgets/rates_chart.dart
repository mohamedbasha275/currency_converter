import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:currency_converter/core/resources/app_text_styles.dart';
import 'package:currency_converter/features/historical_rates/domain/entities/historical_rate_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RatesChart extends HookWidget {
  /// List of historical currency rates
  final List<HistoricalRateEntity> rates;

  const RatesChart({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    /// Main line color
    final lineColor = AppColors.primary;

    /// Used to trigger chart animation after first frame
    final animate = useState(false);

    /// Cached & sorted rates (reversed once)
    final reversedRates = useMemoized(() => rates.reversed.toList(), [rates]);

    /// Cached min & max Y values for chart bounds
    final minMaxY = useMemoized(() {
      final values = reversedRates.map((e) => e.rate).toList();
      return (
        min: values.reduce((a, b) => a < b ? a : b) * 0.99,
        max: values.reduce((a, b) => a > b ? a : b) * 1.01,
      );
    }, [reversedRates]);

    // Start animation after first frame
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animate.value = true;
      });
      return null;
    }, []);
    if (reversedRates.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final spots = List.generate(
      reversedRates.length,
      (i) => FlSpot(i.toDouble(), reversedRates[i].rate),
    );

    final flat = (List<FlSpot> spots) => spots.map((s) => FlSpot(s.x, spots.first.y)).toList();

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (reversedRates.length - 1).toDouble(),
        minY: minMaxY.min,
        maxY: minMaxY.max,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.dashedChart,
            strokeWidth: 1.2,
            dashArray: [4, 4],
          ),
          getDrawingVerticalLine: (_) => FlLine(
            color: AppColors.dashedChart,
            strokeWidth: 1.2,
            dashArray: [4, 4],
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 0.9 * ((minMaxY.max - minMaxY.min) / 3),
              reservedSize: 40,
              getTitlesWidget: (v, _) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: AppText(
                  v.toStringAsFixed(2),
                  style: AppTextStyles.captionBlueGreyReg,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 24,
              getTitlesWidget: (v, _) {
                final index = v.toInt();
                if (index < 0 || index >= reversedRates.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: AppText(
                    reversedRates[index].chartDateLabel,
                    style: AppTextStyles.captionBlueGreyReg.copyWith(fontSize: 8),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.primary2,
            tooltipRoundedRadius: 12,
            getTooltipItems: (spots) => spots.map((spot) {
              final rate = reversedRates[spot.x.toInt()];
              return LineTooltipItem(
                '${rate.formattedRate}\n',
                const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  TextSpan(
                    text: rate.formattedDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: animate.value ? spots : flat(spots),
            isCurved: true,
            barWidth: 3,
            color: lineColor,
            dotData: FlDotData(
              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                radius: 5,
                color: lineColor,
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  lineColor.withValues(alpha: 0.18),
                  lineColor.withValues(alpha: 0.2),
                  lineColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
    );
  }
}

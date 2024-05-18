import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_stats_app/core/presentation/widgets/my_text.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class LineChartView extends StatefulWidget {
  final Map<String, int> totalLettersCount;
  const LineChartView({required this.totalLettersCount, super.key});

  @override
  State<LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<LineChartView> {
  List<Color> gradientColors = [
    AppColors.primary.withOpacity(0.5),
    AppColors.primary,
  ];

  Future<List<FlSpot>>? _spotsFuture;
  double maxY = 0;

  @override
  void initState() {
    super.initState();
    _spotsFuture = compute(_generateNormalizedSpots, widget.totalLettersCount);
  }

  static List<FlSpot> _generateNormalizedSpots(
      Map<String, int> totalLettersCount) {
    final maxValue = totalLettersCount.values.reduce((a, b) => a > b ? a : b);
    final scaleFactor = maxValue / 100;
    return totalLettersCount.values
        .toList()
        .asMap()
        .entries
        .map((entry) =>
            FlSpot(entry.key.toDouble(), entry.value.toDouble() / scaleFactor))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<FlSpot>>(
        future: _spotsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: MyText('Error loading data'));
          } else {
            final spots = snapshot.data!;
            final values = widget.totalLettersCount.values.toList();
            values.sort();
            maxY = values.last.toDouble();
            return LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (group) => Colors.black54,
                      tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      tooltipRoundedRadius: 100,
                      tooltipMargin: 16,
                      getTooltipItems: (spots) {
                        return spots
                            .map(
                              (e) => LineTooltipItem(
                                widget.totalLettersCount.values
                                    .toList()[e.spotIndex]
                                    .toString(),
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            .toList();
                      },
                    )),
                gridData: const FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: Text(
        widget.totalLettersCount.keys.toList()[value.toInt()],
        style: style,
      ),
    );
  }
}

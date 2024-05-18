import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:github_stats_app/core/utils/colors.dart';

class BarChartView extends StatelessWidget {
  final Map<String, int> totalLettersCount;
  const BarChartView({super.key, required this.totalLettersCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups(context),
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: totalLettersCount.values.toList().last.toDouble(),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.black54,
          tooltipPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          tooltipRoundedRadius: 100,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              totalLettersCount.values.toList()[groupIndex].toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: Text(
        totalLettersCount.keys.toList()[value.toInt()],
        style: style,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> barGroups(context) => totalLettersCount.values
      .toList()
      .mapIndexed(
        (i, e) => BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: e.toDouble() / 35,
              color: AppColors.primary,
            )
          ].toList(),
        ),
      )
      .toList();
}

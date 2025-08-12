import 'dart:math';

import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({super.key});

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  String selectedRange = 'This Week';
  final Map<String, List<List<double>>> stepDataMap = {
    'This Week': [
      [2, 3],
      [3, 3.5],
      [2.5, 2.5],
      [4, 3.5],
      [2, 2],
      [2.5, 2],
      [3, 2],
    ],
    'This Month': [
      [2, 3],
      [3, 3.5],
      [2.5, 2.5],
      [4, 3.5],
    ],
  };
  List<List<double>> get currentStepData => stepDataMap[selectedRange]!;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [AppColor.chartGradient1, AppColor.chartGradient2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              Expanded(child: _buildChart()),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, FlErrorRange errorRange) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          toYErrorRange: errorRange,
          color: x >= 4 ? Colors.transparent : const Color.fromARGB(255, 177, 124, 74),
          borderRadius: BorderRadius.zero,
          borderDashArray: x >= 4 ? [4, 4] : null,
          width: 22,
          borderSide: BorderSide(color:  const Color.fromARGB(255, 177, 124, 74), width: 2.0),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
            color: AppColor.textWhite,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    Widget text = Text(days[value.toInt()], style: style);

    return SideTitleWidget(meta: meta, space: 16, child: text);
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          'CALORIES OVERVIEW',
          style: TextStyle(
                  color: AppColor.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black45,
            border: Border.all(color: AppColor.borderColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.grey[900],
              value: selectedRange,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              items:
                  ['This Week', 'This Month']
                      .map(
                        (label) => DropdownMenuItem(
                          value: label,
                          child: Text(
                            label,
                            style:  TextStyle(
                                    color: AppColor.textWhite,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() => selectedRange = value!);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return BarChart(
      BarChartData(
        maxY: 3000.0,
        barTouchData: const BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, _) {
                if (value % 2 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    selectedRange == 'This Week'
                        ? days[value.toInt()]
                        : days[value.toInt()],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: List.generate(7, (i) {
          final y = Random().nextInt(2950).toDouble() + 10;
          final lowerBy =
              y < 50
                  ? Random().nextDouble() * 10
                  : Random().nextDouble() * 30 + 5;
          final upperBy =
              y > 2950
                  ? Random().nextDouble() * 10
                  : Random().nextDouble() * 30 + 5;
          return makeGroupData(
            i,
            y,
            FlErrorRange(lowerBy: lowerBy, upperBy: upperBy),
          );
        }),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine:
              (value) => FlLine(
                color: const Color.fromARGB(87, 255, 255, 255),
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
          drawVerticalLine: false,
        ),
      ),
    );
  }
}

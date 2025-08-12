import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatefulWidget {
  const WeightChart({super.key});

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
   String selectedRange = 'This Week';
  final Color activeColor = Colors.blueGrey;
  final Color remainingColor = const Color(0xFF4D6169);
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          'WEIGHT OVERVIEW',
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
              icon: Icon(Icons.keyboard_arrow_down, color: AppColor.textWhite),
              items:
                  ['This Week', 'This Month']
                      .map(
                        (label) => DropdownMenuItem(
                          value: label,
                          child: Text(
                            label,
                            style: TextStyle(
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
        maxY: 8,
        barGroups: List.generate(currentStepData.length, (i) {
          final active = currentStepData[i][0];
          final remaining = currentStepData[i][1];
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                width: 18,
                borderRadius: BorderRadius.circular(2),
                rodStackItems: [
                  BarChartRodStackItem(0, active, activeColor),
                  BarChartRodStackItem(
                    active,
                    active + remaining,
                    remainingColor,
                  ),
                ],
                toY: active,
              ),
            ],
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
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, _) {
                if (value % 2 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}0kg',
                  style:  TextStyle(color: AppColor.textWhite, fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                const month = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    selectedRange == 'This Week'
                        ? days[value.toInt()]
                        : month[value.toInt()],
                    style:  TextStyle(color: AppColor.textWhite, fontSize: 12),
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
        barTouchData: BarTouchData(enabled: false),
      ),
    );
  }
}
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

BarTouchData get barTouchData => BarTouchData(
  enabled: false,
  touchTooltipData: BarTouchTooltipData(
    getTooltipColor: (group) => Colors.transparent,
    tooltipPadding: EdgeInsets.zero,
    tooltipMargin: 8,
    getTooltipItem: (
      BarChartGroupData group,
      int groupIndex,
      BarChartRodData rod,
      int rodIndex,
    ) {
      return BarTooltipItem(
        rod.toY.round().toString(),
        TextStyle(color: Colors.white54),
      );
    },
  ),
);

Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(color: Colors.white, fontSize: 10);
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'MON';
      break;
    case 1:
      text = 'TUE';
      break;
    case 2:
      text = 'WED';
      break;
    case 3:
      text = 'THU';
      break;
    case 4:
      text = 'FRI';
      break;
    case 5:
      text = 'SAT';
      break;
    case 6:
      text = 'SUN';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(meta: meta, space: 4, child: Text(text, style: style));
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
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 35,
      getTitlesWidget: (value, _) {
        if (value % 2 != 0) return const SizedBox.shrink();
        return Text(
          '${value.toInt()}k',
          style: const TextStyle(color: Colors.white, fontSize: 10),
        );
      },
    ),
  ),
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
);

FlBorderData get borderData => FlBorderData(show: false);

LinearGradient get _barsGradient => LinearGradient(
  colors: [Color(0xFF96FFFE), Color(0xFFF7C201)],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

List<BarChartGroupData> get barGroups => [
  BarChartGroupData(
    x: 0,
    barRods: [BarChartRodData(toY: 8, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 1,
    barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 2,
    barRods: [BarChartRodData(toY: 14, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 3,
    barRods: [BarChartRodData(toY: 15, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 4,
    barRods: [BarChartRodData(toY: 13, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 5,
    barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 6,
    barRods: [BarChartRodData(toY: 16, gradient: _barsGradient)],
    showingTooltipIndicators: [0],
  ),
];

class Spo2VitalsChart extends StatefulWidget {
  const Spo2VitalsChart({super.key});

  @override
  State<StatefulWidget> createState() => Spo2VitalsChartState();
}

class Spo2VitalsChartState extends State<Spo2VitalsChart> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SPO2 OVERVIEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Last 7 Days',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: barGroups,
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
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

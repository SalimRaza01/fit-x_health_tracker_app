import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

LineTouchData get lineTouchData2 => const LineTouchData(enabled: false);

FlTitlesData get titlesData2 => FlTitlesData(
  bottomTitles: AxisTitles(sideTitles: bottomTitles),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  leftTitles: AxisTitles(sideTitles: leftTitles()),
);

List<LineChartBarData> get lineBarsData2 => [
  lineChartBarData2_2,
  lineChartBarData2_3,
];

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 12, color: Colors.white54);
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1m';
      break;
    case 2:
      text = '2m';
      break;
    case 3:
      text = '3m';
      break;
    case 4:
      text = '5m';
      break;
    case 5:
      text = '6m';
      break;
    default:
      return Container();
  }

  return SideTitleWidget(
    meta: meta,
    child: Text(text, style: style, textAlign: TextAlign.center),
  );
}

SideTitles leftTitles() => SideTitles(
  getTitlesWidget: leftTitleWidgets,
  showTitles: true,
  interval: 1,
  reservedSize: 40,
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

SideTitles get bottomTitles => SideTitles(
  showTitles: true,
  reservedSize: 32,
  interval: 1,
  getTitlesWidget: getTitles,
);

LineChartBarData get lineChartBarData2_2 => LineChartBarData(
  isCurved: true,
  color: Colors.amber,
  barWidth: 4,
  isStrokeCapRound: true,
  dotData: const FlDotData(show: false),
  belowBarData: BarAreaData(show: false, color: Colors.amberAccent),
  spots: const [
    FlSpot(1, 2),
    FlSpot(2, 2.8),
    FlSpot(3, 2.8),
    FlSpot(4, 2.6),
    FlSpot(5, 3.9),
    FlSpot(6, 1.2),
  ],
);

LineChartBarData get lineChartBarData2_3 => LineChartBarData(
  isCurved: true,
  curveSmoothness: 0,
  color: Colors.cyanAccent,
  barWidth: 2,
  isStrokeCapRound: true,
  dotData: const FlDotData(show: true),
  belowBarData: BarAreaData(show: false),
  spots: const [
    FlSpot(1, 3.8),
    FlSpot(2, 5),
    FlSpot(3, 3.3),
    FlSpot(4, 4.5),
    FlSpot(6, 1.9),
  ],
);

class StrainLevelChart extends StatefulWidget {
  const StrainLevelChart({super.key});

  @override
  State<StatefulWidget> createState() => StrainLevelChartState();
}

class StrainLevelChartState extends State<StrainLevelChart> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

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
                    'STRAIN LEVEL',
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
              const SizedBox(height: 10),
              Expanded(
                child: LineChart(
                  LineChartData(
                    lineTouchData: lineTouchData2,
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
                    titlesData: titlesData2,
                    borderData: FlBorderData(show: false),
                    lineBarsData: lineBarsData2,
                    minX: 0,
                    maxX: 7,
                    maxY: 6,
                    minY: 0,
                  ),
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

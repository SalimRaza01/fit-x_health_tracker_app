import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartrateGraph extends StatefulWidget {
  const HeartrateGraph({super.key});

  @override
  State<HeartrateGraph> createState() => _HeartrateGraphState();
}

class _HeartrateGraphState extends State<HeartrateGraph> {
  List<Color> gradientColors = [Color(0xFFF7C201), Color(0xFF0CD4E9)];


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
                    'REST HEART RATE',
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
              Expanded(child: LineChart(mainData())),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
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
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  days[value.toInt()],

                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            },
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
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 6,

      minY: 0,
      maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors:
                  gradientColors
                      .map((color) => color.withValues(alpha: 0.3))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

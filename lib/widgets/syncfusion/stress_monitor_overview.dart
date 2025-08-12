import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StressMonitorOverview extends StatelessWidget {
  const StressMonitorOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
color: AppColor.chartBG,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.nightlight_round, color: Colors.white70, size: 18),
                  SizedBox(width: 6),
                  Text(
                    "STRESS MONITOR",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "LAST UPDATED 18:34",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),

          AspectRatio(
            aspectRatio: 1.9,
            child: SfCartesianChart(
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              backgroundColor: Colors.transparent,

              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('ha'),
                intervalType: DateTimeIntervalType.hours,
                labelIntersectAction: AxisLabelIntersectAction.none,
                labelRotation: 0,

                interval: 6,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: TextStyle(color: AppColor.textGrey),

                majorTickLines: MajorTickLines(width: 1),
              ),

              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 4,
                interval: 1,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
                plotBands: <PlotBand>[
                  PlotBand(
                    start: 0,
                    end: 2,
                    color: const Color(0xFF4CAF50).withOpacity(0.07),
                  ), // soft green
                  PlotBand(
                    start: 2,
                    end: 3,
                    color: const Color(0xFFFFC107).withOpacity(0.07),
                  ), // amber
                  PlotBand(
                    start: 3,
                    end: 4,
                    color: const Color(0xFFF44336).withOpacity(0.07),
                  ), // red
                ],
              ),

              series: <SplineSeries<StressData, DateTime>>[
                SplineSeries<StressData, DateTime>(
                  dataSource: stressData,
                  xValueMapper: (StressData data, _) => data.time,
                  yValueMapper: (StressData data, _) => data.stress,
                  pointColorMapper: (StressData data, _) {
                    if (data.stress < 2) return Colors.greenAccent;
                    if (data.stress < 3) return Colors.amber;
                    return Colors.redAccent;
                  },
                  width: 2,
                  markerSettings: const MarkerSettings(isVisible: false),
                ),
              ],

              annotations: <CartesianChartAnnotation>[
                CartesianChartAnnotation(
                  widget: const Icon(
                    Icons.nightlight_round,
                    color: Colors.white70,
                    size: 18,
                  ),
                  coordinateUnit: CoordinateUnit.point,
                  x: DateTime(2025, 8, 8, 6, 0),
                  y: 3,
                ),
                CartesianChartAnnotation(
                  widget: const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 18,
                  ),
                  coordinateUnit: CoordinateUnit.point,
                  x: DateTime(2025, 8, 8, 15, 0),
                  y: 2.8,
                ),
                CartesianChartAnnotation(
                  widget: const Icon(
                    Icons.self_improvement,
                    color: Colors.white,
                    size: 18,
                  ),
                  coordinateUnit: CoordinateUnit.point,
                  x: DateTime(2025, 8, 8, 18, 0),
                  y: 2.3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StressData {
  final DateTime time;
  final double stress;
  StressData(this.time, this.stress);
}

final List<StressData> stressData = [
  StressData(DateTime(2025, 8, 8, 0, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 1, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 2, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 3, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 4, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 5, 0), 0.0),
  StressData(DateTime(2025, 8, 8, 6, 0), 0.5),
  StressData(DateTime(2025, 8, 8, 7, 0), 1.2),
  StressData(DateTime(2025, 8, 8, 8, 0), 1.8),
  StressData(DateTime(2025, 8, 8, 9, 0), 2.0),
  StressData(DateTime(2025, 8, 8, 10, 0), 2.4),
  StressData(DateTime(2025, 8, 8, 11, 0), 2.6),
  StressData(DateTime(2025, 8, 8, 12, 0), 2.3),
  StressData(DateTime(2025, 8, 8, 13, 0), 2.1),
  StressData(DateTime(2025, 8, 8, 14, 0), 2.5),
  StressData(DateTime(2025, 8, 8, 15, 0), 2.8),
  StressData(DateTime(2025, 8, 8, 16, 0), 2.6),
  StressData(DateTime(2025, 8, 8, 17, 0), 2.4),
  StressData(DateTime(2025, 8, 8, 18, 0), 2.3),

  StressData(DateTime(2025, 8, 8, 19, 34), 2.0),
  StressData(DateTime(2025, 8, 8, 20, 0), 2.0),
  StressData(DateTime(2025, 8, 8, 21, 0), 2.0),
  StressData(DateTime(2025, 8, 8, 22, 0), 2.0),
  StressData(DateTime(2025, 8, 8, 23, 34), 2.0),
];

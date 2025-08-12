import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StrainRecoveryOverview extends StatelessWidget {
  const StrainRecoveryOverview({super.key});

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
          // Title
          Row(
            children: [
              Icon(CupertinoIcons.slowmo, color: AppColor.textGrey, size: 18),
              SizedBox(width: 6),
              Text(
                "STRAIN & RECOVERY",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "LAST UPDATED 09:15",
            style: TextStyle(
              color: AppColor.textGrey,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          // Chart
          AspectRatio(
            aspectRatio: 1.9,
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),

              margin: EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                labelIntersectAction: AxisLabelIntersectAction.none,
                labelRotation: 0,

                interval: 1,
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: TextStyle(color: AppColor.textGrey),
                labelPlacement: LabelPlacement.betweenTicks,

                majorTickLines: MajorTickLines(width: 1),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 100,
                interval: 25,
                labelStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
                majorGridLines: const MajorGridLines(
                  width: 0,
                  color: Colors.white24,
                ),
                axisLine: const AxisLine(width: 0),
              ),
              series: <CartesianSeries>[
                // Yellow percentage line
                SplineSeries<ChartData, String>(
                  color: Colors.amber,
                  width: 2,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    color: Colors.amber,
                    borderColor: Colors.black,
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataSource: [
                    ChartData("12AM", 60, "32%"),
                    ChartData("6AM", 90, "48%"),
                    ChartData("12PM", 85, "45%"),
                    ChartData("6PM", 50, "25%"),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) => data.label,
                ),
                // Blue strain line
                SplineSeries<ChartData, String>(
                  color: Colors.blue,
                  width: 2,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    color: Colors.blue,
                    borderColor: Colors.black,
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dataSource: [
                    ChartData("12AM", 25, ""),
                    ChartData("6AM", 55, ""),
                    ChartData("12PM", 60, ""),
                    ChartData("6PM", 70, ""),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) => data.label,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final String label;
  ChartData(this.x, this.y, this.label);
}

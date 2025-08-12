import 'package:dotted_border/dotted_border.dart';
import 'package:fit_x/core/constants/app_colors.dart' show AppColor;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StepsOverviewChart extends StatelessWidget {
  final List<StepsData> stepsData = [
    StepsData("12AM", 350),
    StepsData("1AM", 150),
    StepsData("2AM", 550),
    StepsData("3AM", 950),
    StepsData("4AM", 750),
    StepsData("5AM", 400),
    StepsData("6AM", 600),
    StepsData("7AM", 350),
    StepsData("8AM", 550),
    StepsData("9AM", 450),
    StepsData("10AM", 700),
    StepsData("11AM", 950),
    StepsData("12PM", 1000),
    StepsData("1PM", 800),
    StepsData("2PM", 450),
    StepsData("3PM", 600),
    StepsData("4PM", 350),
    StepsData("5PM", 550),
    StepsData("6PM", 850),
    StepsData("7PM", 600),
    StepsData("8PM", 150),
    StepsData("9PM", 120),
    StepsData("10PM", 80),
    StepsData("11PM", 50),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(10),
          color: AppColor.borderColor,
          strokeWidth: 1,
          dashPattern: [6, 3], 
        ),
      
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TOTAL",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "4,432",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "steps",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const Text(
                "Today",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.none,
                    labelRotation: 0,
      
                    interval: 6,
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: const TextStyle(color: Colors.white70),
                    labelPlacement: LabelPlacement.betweenTicks,
      
                    majorTickLines: MajorTickLines(width: 1),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: const TextStyle(color: Colors.white70),
                    maximum: 1000,
                    interval: 500,
                    opposedPosition: true,
                    placeLabelsNearAxisLine: true,
                  ),
      
                  series: <CartesianSeries>[
                    ColumnSeries<StepsData, String>(
                      dataSource: stepsData,
                      xValueMapper: (StepsData data, _) => data.time,
                      yValueMapper: (StepsData data, _) => data.steps,
                      borderRadius: BorderRadius.circular(2),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF01579B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      width: 0.5, // bar thickness matches image
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepsData {
  late String? time;
  final double steps;
  StepsData(this.time, this.steps);
}

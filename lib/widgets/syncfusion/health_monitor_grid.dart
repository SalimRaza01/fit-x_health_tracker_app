import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HealthMonitorGrid extends StatelessWidget {
  const HealthMonitorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: GridView.count(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
        children: const [
          HealthCard(
            title: "HEART RATE",
            value: "90",
            unit: "bpm",
            chart: HRbarCard(chartColor: Colors.pink),
          ),
          HealthCard(
            title: "SLEEP",
            value: "06h46",
            unit: "min",
            chart: SleepBarCard(chartColor: Colors.blue),
          ),
          HealthCard(
            title: "BLOOD PRESSURE",
            value: "116/72",
            unit: "mmHg",
            chart: BPbarCard(),
          ),
          HealthCard(
            title: "SpO₂",
            value: "98",
            unit: "%",
            chart: SpO2barCard(chartColor: Colors.green),
          ),
        ],
      ),
    );
  }
}

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Widget chart;

  const HealthCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [AppColor.chartGradient2, AppColor.chartGradient1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              letterSpacing: 1,
            ),
          ),
          Expanded(child: chart),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HRbarCard extends StatelessWidget {
  final Color chartColor;
  const HRbarCard({super.key, required this.chartColor});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        SplineSeries<ChartData, double>(
          color: chartColor,
          dataSource: List.generate(
            15,
            (index) => ChartData(
              index.toDouble(),
              (5 + (index.isEven ? index * 0.8 : index * 0.4)) *
                  (index.isOdd ? 1.2 : 0.8),
            ),
          ),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          width: 2,
        ),
      ],
    );
  }
}

class SpO2barCard extends StatelessWidget {
  final Color chartColor;
  const SpO2barCard({super.key, required this.chartColor});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        SplineSeries<ChartData, double>(
          color: chartColor,
          dataSource: List.generate(
            15,
            (index) => ChartData(
              index.toDouble(),
              (5 + (index.isEven ? index * 0.8 : index * 0.4)) *
                  (index.isOdd ? 1.2 : 0.8),
            ),
          ),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          width: 2,
        ),
      ],
    );
  }
}

class SleepBarCard extends StatelessWidget {
  final Color chartColor;
  const SleepBarCard({super.key, required this.chartColor});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        ColumnSeries<ChartData, double>(
          width: 0.5,
          color: chartColor,
          dataSource: List.generate(
            12,
            (index) => ChartData(
              index.toDouble(),
              index.isOdd ? (index * 2).toDouble() : 4,
            ),
          ),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }
}

class BPbarCard extends StatelessWidget {
  const BPbarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        SplineSeries<ChartData, double>(
          color: Colors.yellow,
          dataSource: List.generate(
            10,
            (i) => ChartData(i.toDouble(), (i * 12.5) + 4),
          ),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          width: 2,
           markerSettings: const MarkerSettings(isVisible: true, height: 5.0, width: 5.0, color: Colors.black),
        ),
        SplineSeries<ChartData, double>(
          color: Colors.blue,
          dataSource: List.generate(
            10,
            (i) => ChartData(i.toDouble(), (i * 1.2) + 2),
          ),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: true, height: 5.0, width: 5.0, color: Colors.black),
        ),
      ],
    );
  }
}

class ChartData {
  final double x;
  final double y;
  ChartData(this.x, this.y);
}

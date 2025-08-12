import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MetricData {
  final DateTime time;
  final double strain;
  final double recovery;
  final double sleep;
  final double hrv;

  MetricData(this.time, this.strain, this.recovery, this.sleep, this.hrv);
}

class OtherWidgetView extends StatelessWidget {
  final VoidCallback onSwitch;

  const OtherWidgetView({super.key, required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    final List<MetricData> data = List.generate(
      50,
          (i) {
        final time = DateTime(2025, 6, 3, 0).add(Duration(hours: i));
        return MetricData(
          time,
          6 + Random().nextDouble() * 4,
          30 + Random().nextDouble() * 40,
          50 + Random().nextDouble() * 40,
          20 + Random().nextDouble() * 40,
        );
      },
    );

    final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
    );

    return Stack(
      children: [
        Container(
          height: 260,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // color: const Color(0xFF031E2B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SfCartesianChart(
            backgroundColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              textStyle: TextStyle(color: Colors.white70),
            ),
            tooltipBehavior: TooltipBehavior(enable: true, header: '', format: 'point.x : point.y'),
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              intervalType: DateTimeIntervalType.hours,
              majorGridLines: MajorGridLines(width: 0),
              labelStyle: TextStyle(color: Colors.white60),
              axisLine: AxisLine(color: Colors.white24),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 100,
              interval: 20,
              majorGridLines: MajorGridLines(width: 0.5, dashArray: [4, 4]),
              axisLine: AxisLine(color: Colors.white24),
              labelStyle: TextStyle(color: Colors.white60),
            ),
            series: <CartesianSeries>[
              LineSeries<MetricData, DateTime>(
                name: 'Strain',
                dataSource: data,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.strain,
                color: Colors.blueAccent,
                width: 2,
              ),
              LineSeries<MetricData, DateTime>(
                name: 'Recovery',
                dataSource: data,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.recovery,
                color: Colors.redAccent,
                width: 2,
              ),
              LineSeries<MetricData, DateTime>(
                name: 'Sleep',
                dataSource: data,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.sleep,
                color: Colors.tealAccent,
                width: 2,
              ),
              LineSeries<MetricData, DateTime>(
                name: 'HRV',
                dataSource: data,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.hrv,
                color: Colors.yellowAccent,
                width: 2,
              ),
            ],
          ),
        ),

        // Top-right toggle icon
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: const Icon(Icons.swap_horiz, color: Colors.white70),
            onPressed: onSwitch,
          ),
        ),
      ],
    );
  }
}

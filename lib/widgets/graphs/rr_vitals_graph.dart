import 'dart:async';
import 'dart:math';
import 'package:fit_x/core/provider/startMonitoring.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RrVitalsGraph extends StatefulWidget {
  const RrVitalsGraph({super.key});

  @override
  State<RrVitalsGraph> createState() => _RrVitalsGraphState();
}

class _RrVitalsGraphState extends State<RrVitalsGraph> {
  List<FlSpot> dataPoints = [];
  double xValue = 0;
  final int maxPoints = 50;
  late Timer timer;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  void start() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      setState(() {
        double newY = 3 + random.nextDouble() * 5;
        dataPoints.add(FlSpot(xValue, newY));
        xValue += 1;

        if (dataPoints.length > maxPoints) {
          dataPoints.removeAt(0);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final monitor = Provider.of<Startmonitoring>(context);

    if (monitor.status == true) {
      start();
    } else if (monitor.status == false) {
      timer.cancel();
      setState(() {
        dataPoints = [];
        xValue = 0;
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5),
              const Icon(
                CupertinoIcons.waveform_path_ecg,
                color: Colors.white,
                size: 15,
              ),
              Text(
                xValue.toString(),
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                'BPM',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: AspectRatio(
            aspectRatio: 4.0,
            child: LineChart(
              LineChartData(
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
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: dataPoints.isNotEmpty ? dataPoints.first.x : 0,
                maxX:
                    dataPoints.isNotEmpty
                        ? dataPoints.last.x
                        : maxPoints.toDouble(),
                minY: 0,
                maxY: 8,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: const Color.fromARGB(255, 255, 224, 24),
                    barWidth: 1,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(
                            255,
                            255,
                            205,
                            24,
                          ).withOpacity(0.4),
                          const Color.fromARGB(
                            255,
                            200,
                            167,
                            0,
                          ).withOpacity(0.1),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    spots:
                        dataPoints.isNotEmpty
                            ? dataPoints
                            : [FlSpot(1, 4), FlSpot(50, 4)],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

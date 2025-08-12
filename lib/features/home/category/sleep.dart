
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/core/data/models/sleep_model.dart';
import 'package:fit_x/widgets/graphs/sleep_efficiency_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../widgets/dashed_circular_progress_indicator.dart';

class Sleep extends StatefulWidget {
  const Sleep({super.key});

  @override
  State<Sleep> createState() => _SleepState();
}

class _SleepState extends State<Sleep> {
  final List<SleepData> sleepData = [
    SleepData('MON', 5, 7),
    SleepData('TUE', 6, 7),
    SleepData('WED', 8, 7),
    SleepData('THU', 4, 7),
    SleepData('FRI', 6, 7),
    SleepData('SAT', 6, 7),
    SleepData('SUN', 5, 7),
  ];

  String selectedRange = 'This Week';
  final Color activeColor = Color(0xFF00CFFF);
  final Color remainingColor = Color(0xFF0D41A1);

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

  final double sleepPercent = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
      colors: [
                AppColor.backgroundLineartop,
                AppColor.backgroundLinearbottom,
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Sleep Performance Ring
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white),
                    SizedBox(width: 25),
                    Text(
                      'TODAY',
                      style: TextStyle(color: AppColor.textWhite, fontSize: 15),
                    ),
                    SizedBox(width: 25),
                    Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
                SizedBox(height: 25),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: DashedCircularSeekBar(percent: sleepPercent),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 40),
                        Text(
                          '75%',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'SLEEP',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'PERFORMANCE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '5:25',
                          style: TextStyle(
                            color: activeColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: activeColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'HRS OF SLEEP',
                              style: TextStyle(
                                color: activeColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '9:55',
                          style: TextStyle(
                            color: Color(0xff00FFBC),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Color(0xff00FFBC)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'SLEEP NEEDED',
                              style: TextStyle(
                                color: Color(0xff00FFBC),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Tip Box
                Column(
                  children: [
                    Text(
                      'Keep Recovery Strong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),

                      child: const Text(
                        'You didn’t get enough sleep last night, but your body may be recovered due to other lifestyle factors. Keep this trend going and improve your training by meeting your sleep need tonight.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sleep Activities',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                buildSleepTiles(
                  'Time in Bed',
                  '49%',
                  CupertinoIcons.bed_double,
                  Colors.grey,
                ),
                const SizedBox(height: 12),
                buildSleepTiles(
                  'Consistency',
                  '14.5',
                  CupertinoIcons.rays,
                  Colors.grey,
                ),
                const SizedBox(height: 12),
                buildSleepTiles(
                  'Restorative Sleep',
                  '54%',
                  CupertinoIcons.timer,
                  Colors.grey,
                ),
                const SizedBox(height: 20),
                sleepStatsGraph(),
                const SizedBox(height: 20),
                hourVSneedGraph(),
                const SizedBox(height: 20),
                SleepEfficiencyGraph(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AspectRatio hourVSneedGraph() {
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
          child: SfCartesianChart(
            plotAreaBorderColor: Colors.transparent,
            plotAreaBackgroundColor: Colors.transparent,
            plotAreaBorderWidth: 0.0,

            backgroundColor: Colors.transparent,
            // title: ChartTitle(
            //   text: 'HOURS VS NEED (LAST 7 DAYS)',
            //   alignment: ChartAlignment.near,
            //   textStyle: const TextStyle(color: Colors.white, fontSize: 14),
            // ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.top,
              textStyle: const TextStyle(color: Colors.white),
            ),
            primaryXAxis: CategoryAxis(
              majorTickLines: MajorTickLines(width: .0),
              majorGridLines: MajorGridLines(color: Colors.blueGrey),
              axisLine: const AxisLine(width: 0, color: Colors.transparent),
              labelStyle: const TextStyle(color: Colors.white),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 10,
              isVisible: false,
            ),

            series: <CartesianSeries>[
              ColumnSeries<SleepData, String>(
                borderWidth: .0,
                name: 'SLEEP NEEDED',
                dataSource: sleepData,
                xValueMapper: (SleepData data, _) => data.day,
                yValueMapper: (SleepData data, _) => data.sleepNeeded,
                pointColorMapper:
                    (_, __) => const Color.fromARGB(255, 13, 65, 161),
                width: 0.4,
              ),
              ColumnSeries<SleepData, String>(
                borderWidth: .0,
                name: 'HRS OF SLEEP',
                dataSource: sleepData,
                xValueMapper: (SleepData data, _) => data.day,
                yValueMapper:
                    (SleepData data, _) =>
                        data.hoursOfSleep > data.sleepNeeded
                            ? data.hoursOfSleep - data.sleepNeeded
                            : data.hoursOfSleep,
                pointColorMapper:
                    (SleepData data, _) =>
                        data.hoursOfSleep > data.sleepNeeded
                            ? const Color(0xFF00CFFF)
                            : const Color(0xFF00CFFF),
                width: 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSleepTiles(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        color: AppColor.universalGrey,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(fontSize: 14, color: iconColor)),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF16D3DE),
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio sleepStatsGraph() {
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
        const Text(
          'SLEEP PERFORMANCE',
          style: TextStyle(
            color: Colors.white,
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
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              items:
                  ['This Week', 'This Month']
                      .map(
                        (label) => DropdownMenuItem(
                          value: label,
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
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
                borderRadius: BorderRadius.circular(6),
                rodStackItems: [
                  BarChartRodStackItem(0, active, activeColor),
                  BarChartRodStackItem(
                    active,
                    active + remaining,
                    remainingColor,
                  ),
                ],
                toY: active + remaining,
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
                  '${value.toInt()}k',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
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
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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


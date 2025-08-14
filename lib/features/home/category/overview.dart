// ignore_for_file: unused_element
import 'package:fit_x/widgets/syncfusion/food_tracker_widget.dart';
import 'package:fit_x/widgets/radial_chart.dart';
import 'package:fit_x/widgets/syncfusion/health_monitor_grid.dart';
import 'package:fit_x/widgets/syncfusion/stress_monitor_overview.dart';
import 'package:fit_x/widgets/syncfusion/steps_overview_chart.dart';
import 'package:fit_x/widgets/syncfusion/strain_recovery_overview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  // color: const Color(0xFF0E1B26),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [],
                ),
                child: ActivityRingsWidget(onSwitch: () {}),
              ),
              InkWell(
                onTap: () {
                  context.push('/foodMainScreen');
                },
                child: TrackFoodCard()),
              StepsOverviewChart(),
              HealthMonitorGrid(),
              StressMonitorOverview(),
              StrainRecoveryOverview(),
              SizedBox(height: 100),
            ],
          ),

        ),
      ),
    );
  }
}

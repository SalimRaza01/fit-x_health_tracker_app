import 'package:flutter/material.dart';
import 'package:fit_x/core/services/hive_db_utils.dart';

class TargetGoal extends StatefulWidget {
  const TargetGoal({super.key});

  @override
  State<TargetGoal> createState() => _TargetGoalState();
}

class _TargetGoalState extends State<TargetGoal> {
  final HiveDbHelper _hiveDb = HiveDbHelper();
  double selectedSpeed = 0.5;

  String get paceMessage {
    switch (selectedSpeed) {
      case 0.25:
        return "This is a slow pace, but easier to maintain.";
      case 0.5:
        return "This is a good pace, but you would need to work a bit harder.";
      case 0.75:
        return "This is an ambitious pace, make sure you’re ready.";
      case 1.0:
        return "This is a challenging pace. Stay committed!";
      default:
        return "";
    }
  }

  void saveSpeed() async {
    await _hiveDb.putDouble("weeklyGoalSpeed", selectedSpeed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(

          children: [
            const SizedBox(height: 40),

            // Title
            const Text(
              "HOW FAST DO YOU WANT TO\nREACH YOUR GOAL?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              paceMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 120),
            // Value Display
            Center(
              child: Column(
                children: [
                  Text(
                    "${selectedSpeed.toStringAsFixed(2)} kg",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "per week",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white24,
                thumbColor: Colors.white,
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: selectedSpeed,
                min: 0.25,
                max: 1.0,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    selectedSpeed = double.parse(value.toStringAsFixed(2));
                  });
                },
              ),
            ),

         
          ],
        ),
      ),
    );
  }
}

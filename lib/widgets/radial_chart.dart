import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ActivityRingsWidget extends StatelessWidget {
  final VoidCallback onSwitch;

  const ActivityRingsWidget({super.key, required this.onSwitch});

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _statText("750 kcal", "ACTIVITY", const Color.fromARGB(255, 0, 255, 8), true),
            _statText("1291 kcal", "FOOD", const Color.fromARGB(255, 255, 0, 43), true),
            _statText("75", "M-STRESS", Colors.white, true),
          ],
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 150,
          height: 140,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 0,
                endAngle: 360,
                radiusFactor: 1,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.10,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: -90,
                endAngle: 125,
                radiusFactor: 1,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.10,
                  cornerStyle: CornerStyle.bothCurve,
                  gradient: const SweepGradient(
                    colors: <Color>[
                      Color.fromARGB(78, 207, 27, 51),
                      Colors.pink,
                    ],
                    stops: <double>[0.28, 1.0],
                  ),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),

              //progress2
                RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 0,
                endAngle: 360,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.12,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: -90,
                endAngle: 125,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.12,
                  cornerStyle: CornerStyle.bothCurve,
                  gradient: const SweepGradient(
                       colors: <Color>[
                         Color.fromARGB(30, 83, 155, 0),
                      Colors.lightGreenAccent,
                    ],
                    stops: <double>[0.28, 1.0],
                  ),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
   //progress3
                 RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 0,
                endAngle: 360,
                radiusFactor: 0.6,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.15,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: -90,
                endAngle: 125,
                radiusFactor: 0.6,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.15,
                  cornerStyle: CornerStyle.bothCurve,
                  gradient: const SweepGradient(
                    colors: <Color>[
                      Color.fromARGB(30, 255, 235, 59),
                      Colors.yellow,
                    ],
                    stops: <double>[0.28, 1.0],
                  ),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
   //progress4
   RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 0,
                endAngle: 360,
                radiusFactor: 0.4,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.22,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: -90,
                endAngle: 125,
                radiusFactor: 0.4,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.22,
                  cornerStyle: CornerStyle.bothCurve,
                  gradient: const SweepGradient(
                    colors: <Color>[
                      Color.fromARGB(30, 33, 149, 243),
                      Colors.blue,
                    ],
                    stops: <double>[0.28, 1.0],
                  ),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statText("10.9", "STRESS", Colors.blue, false),
            _statText("53%", "SLEEP", Colors.yellow, false),
            _statText("85%", "P-STRESS", Colors.white, false),
          ],
        ),
      ],
    );
  }

  Widget _statText(String value, String label, Color color, bool leftlabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment:
            leftlabel ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

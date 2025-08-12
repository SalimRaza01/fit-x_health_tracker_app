import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

class DashedCircularSeekBar extends StatelessWidget {
  final double percent;

  const DashedCircularSeekBar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> valueNotifier =
    ValueNotifier(percent * 100); // Convert to percentage

    return CircularSeekBar(
      width: 220,
      height: 220,
      progress: valueNotifier.value,
      barWidth: 8.0,
      startAngle: 45,
      sweepAngle: 270,
      dashWidth: 4.0,
      dashGap: 7.0,
      strokeCap: StrokeCap.round,
      animation: true,
      interactive: false,
      curves: Curves.easeInOut,
      progressGradientColors: const [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.indigo,
        Colors.purple
      ],
      innerThumbRadius: 0,
      outerThumbRadius: 0,
      valueNotifier: valueNotifier,
      child: const SizedBox.shrink(), // No need for child text, handled outside
    );
  }
}

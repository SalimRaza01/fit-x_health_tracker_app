import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/widgets/graphs/heartrate_graph.dart';
import 'package:fit_x/widgets/graphs/heartrate_variability_graph.dart';
import 'package:fit_x/widgets/graphs/recovery_graph.dart';
import 'package:fit_x/widgets/graphs/respiratory_rate_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/dashed_circular_progress_indicator.dart';

class Recovery extends StatelessWidget {
  const Recovery({super.key});

  final double recoveryPercent = 0.85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
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
                 
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      DashedCircularSeekBar(percent: recoveryPercent),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                        
                    SizedBox(height: 50),
                          Text(
                            '${(recoveryPercent * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  SizedBox(height: 20),
                          Text(
                            'TODAY',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'RECOVERY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
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
                        'Estimated HRV',
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
                          'Your HRV is 30% higher than usual. A high HRV indicates your nervous system is ready to handle stress, your body is in balance and you are ready to perform at your peak.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recovery Statistics',
                          
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildRecoveryTiles('Resting Heart Rate', '49 BPM', CupertinoIcons.heart, Colors.grey),
                  const SizedBox(height: 12),
                  buildRecoveryTiles(
                    'Respiratory Rate',
                    '14.5 BPM',
                   CupertinoIcons.dial,
                    Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  buildRecoveryTiles(
                    'Sleep Performance',
                    '54%',
                  CupertinoIcons.light_max,
                    Colors.grey,
                  ),
                  const SizedBox(height: 30),
                  RecoveryGraph(),
                  const SizedBox(height: 20,),
                  HeartrateGraph(),
                       const SizedBox(height: 20),
                                 RespiratoryRateGraph(),
                                          const SizedBox(height: 20),
                                          HeartrateVariabilityGraph(),
                                                   const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget buildRecoveryTiles(
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

  Widget buildMetricRow(String label, String value, Color color, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white54),
              const SizedBox(width: 15),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
        
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
    
            ),
          ),
        ],
      ),
    );
  }
}

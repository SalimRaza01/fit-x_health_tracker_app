import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/widgets/graphs/calories_chart.dart';
import 'package:fit_x/widgets/graphs/weight_chart.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

double weightValue = 30.0;

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();

  static Widget _activityCard(String title, String image) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [AppColor.chartGradient1, AppColor.chartGradient2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(image),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style:  TextStyle(
                     color: AppColor.textWhite,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _historyTile(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.backgroundLineartop,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border.all(color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style:  TextStyle(
                           color: AppColor.textWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "REPS : ",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),

                    Text(
                      "12",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "SET : ",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),

                    Text(
                      "04",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "DURATION : ",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),

                    Text(
                      "30 MIN",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Kcal : ",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),

                    Text(
                      "177",
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 243, 243),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FitnessScreenState extends State<FitnessScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'CALORIES',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(5, 5),
                              blurRadius: 30,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white24,
                              offset: Offset(-5, -1),
                              blurRadius: 30,
                              spreadRadius: 1,
                            ),
                          ],
      
                          borderRadius: BorderRadius.circular(200),
                          gradient: LinearGradient(
                            colors: [
                              AppColor.chartGradient1,
                              AppColor.chartGradient2,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Center(
                        child: CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 15.0,
                          animation: true,
                          percent: 0.72,
                          center:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "3,600",
                                style: TextStyle(
                                       color: AppColor.textWhite,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Kcal",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: AppColor.chartGradient1,
                          progressColor: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '🔥 Total Calories burned',
                  style: TextStyle(
                         color: AppColor.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'These numbers are based on distance and weight',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OVERALL PROGRESS",
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text(" ", style: TextStyle(color: Colors.white60)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.6,
                  minHeight: 4,
                  backgroundColor: Colors.white12,
                  borderRadius: BorderRadius.circular(200),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 28),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "FITNESS ACTIVITY",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FitnessScreen._activityCard(
                      "WORKOUT",
                      "assets/images/GYM.png",
                    ),
                    FitnessScreen._activityCard(
                      "YOGA",
                      "assets/images/YOGA.png",
                    ),
                    FitnessScreen._activityCard(
                      "RUNNING",
                      "assets/images/RUNNINGWORKOUT.png",
                    ),
                    FitnessScreen._activityCard(
                      "CYCLING",
                      "assets/images/CYCLING.png",
                    ),
                  ],
                ),
           const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "HISTORY",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
          const SizedBox(height: 20),
                ListView(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FitnessScreen._historyTile("PUSH-UP", "TODAY"),
                    FitnessScreen._historyTile("PUSH-UP", "YESTERDAY"),
                    FitnessScreen._historyTile("PUSH-UP", "22-JUN-2025"),
                  ],
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "DATA OVERVIEW",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                WeightChart(),
                             const SizedBox(height: 20),
                CaloriesChart(),
      
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

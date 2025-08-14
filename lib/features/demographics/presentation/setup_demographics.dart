// ignore_for_file: unused_field

import 'package:fit_x/features/demographics/presentation/set_things_up.dart';
import 'package:fit_x/features/demographics/presentation/target_weight.dart';
import 'package:fit_x/features/demographics/presentation/medical_condition.dart';
import 'package:fit_x/features/demographics/presentation/height_selection.dart';
import 'package:fit_x/features/demographics/presentation/target_goal.dart';
import 'package:fit_x/features/demographics/presentation/weight_selection.dart';
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupDemographics extends StatefulWidget {
  const SetupDemographics({super.key});

  @override
  State<SetupDemographics> createState() => _SetupDemographicsState();
}

class _SetupDemographicsState extends State<SetupDemographics> {
  final controller = PageController(initialPage: 0);
  int index = 0;



  void finalization(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.push('/appConnect');
    });
  }

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
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap:
                          () => controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          ),
                      child: Icon(
                        CupertinoIcons.chevron_back,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: List.generate(6, (stepIndex) {
                        double progress;

                        if (stepIndex < index) {
                          progress = 1.0;
                        } else if (stepIndex == index) {
                          progress = 0.3;
                        } else {
                          progress = 0.0;
                        }

                        return Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: progress),
                                duration: const Duration(milliseconds: 400),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                    value: value,
                                    borderRadius: BorderRadius.circular(30),
                                    backgroundColor: AppColor.lightGrey,
                                    color: Colors.white,
                                    minHeight: 4,
                                  );
                                },
                              ),
                            ),
                            if (stepIndex != 5) const SizedBox(width: 10),
                          ],
                        );
                      }),
                    ),

                    Icon(
                      CupertinoIcons.chevron_back,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SetThingsUp(),
                    WeightSelection(),
                    HeightSelection(),
                    MedicalConditionsScreen(),
                    TargetWeightScreen(),
                    TargetGoal(),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white38),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  print(index);
                  if (index == 5) {
                    finalization(context);
                  } else {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

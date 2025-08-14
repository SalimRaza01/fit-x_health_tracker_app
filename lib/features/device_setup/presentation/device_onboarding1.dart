import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/core/services/firebase_firestore.dart';
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeviceOnboarding1 extends StatefulWidget {
  const DeviceOnboarding1({super.key});

  @override
  State<DeviceOnboarding1> createState() => _DeviceOnboarding1State();
}

class _DeviceOnboarding1State extends State<DeviceOnboarding1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final HiveDbHelper _hiveDb = HiveDbHelper();

  @override
  void initState() {
    super.initState();
    saveUserData(
        name: _hiveDb.getString('name').toString(),
        age: _hiveDb.getInt('age').toString(),
        dob: _hiveDb.getString('dob').toString(),
        gender: _hiveDb.getString('gender').toString(),
        height: _hiveDb.getDouble('myHeight').toString(),
        weight: _hiveDb.getDouble('myWeight').toString(),
        target_weight: _hiveDb.getString('targetWeight').toString(),
        weekly_goal: _hiveDb.getDouble('weeklyGoalSpeed').toString());
  
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Stack(
            children: [
              Center(child: Image.asset('assets/images/bgTexture1.png')),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding1.png',
                      fit: BoxFit.fitHeight,
                      // height: 500,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(0, 0, 0, 0),
                        AppColor.backgroundLinearbottom,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Text(
                              'PUT ON YOUR FIT-X',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Strap on your FIT-X band to begin tracking your health, activity, and wellness in real time. Stay connected, stay in control.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32),
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
                          context.push('/onboarding2');
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
            ],
          ),
        ),
      ),
    );
  }
}

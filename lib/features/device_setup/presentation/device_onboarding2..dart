
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeviceOnboarding2 extends StatefulWidget {
  const DeviceOnboarding2({super.key});

  @override
  State<DeviceOnboarding2> createState() => _DeviceOnboarding2State();
}

class _DeviceOnboarding2State extends State<DeviceOnboarding2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastLinearToSlowEaseIn));

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
             colors: [AppColor.backgroundLineartop, AppColor.backgroundLinearbottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
           child: Stack(
            children: [
         
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding2.png',
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
                              'WAKE UP YOUR FIT-X',
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
                              'Power on your FIT-X band to start syncing with your device. Let’s get your health and activity data flowing.',
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
                           context.push('/onboarding3');
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

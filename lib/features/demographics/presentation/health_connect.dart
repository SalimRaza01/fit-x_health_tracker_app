import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppleHealthSyncScreen extends StatelessWidget {
  const AppleHealthSyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greyText = Colors.white70;

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "LET’S AUTO TRACK WITH\nAPPLE HEALTH!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Sync all your health data around activity and sleep.\nMore access = faster path to your fitness goal!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: greyText),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/applehealth.png', height: 400,),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
context.push('/onboarding1');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "SYNC WITH APPLE HEALTH",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "No, I’ll Track Everything Manually",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
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

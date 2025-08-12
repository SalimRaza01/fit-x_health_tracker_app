
import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ConnectionProgress extends StatefulWidget {
  const ConnectionProgress({super.key});

  @override
  State<ConnectionProgress> createState() => _ConnectionProgressState();
}

class _ConnectionProgressState extends State<ConnectionProgress>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool showTick = false;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.forward();

    Future.delayed(Duration(seconds: 4), () {
      if (showTick) {
context.push('/mainScreen');
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showTick = true;
      });
    });
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

        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONNECTING FIT-X',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/logo/mobile.svg'),
                  SizedBox(width: 8),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(height: 3, color: Colors.grey.shade800),
                            FractionallySizedBox(
                              widthFactor: _progressAnimation.value,
                              child: Container(
                                height: 3,
                                color: const Color.fromARGB(255, 0, 255, 8),
                              ),
                            ),
                            if (showTick)
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 0, 255, 8),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  showTick ? Icons.check : Icons.close,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset('assets/logo/band.svg'),
                ],
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Text(
                    showTick
                        ? "Device Connected Successfully"
                        : "Making Connection Stable for Best Use",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please wait while we securely connect your Fit-X device. This process ensures accurate syncing of health data and optimal performance tracking.",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

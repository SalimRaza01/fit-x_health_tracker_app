// ignore_for_file: unused_field

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _logoController;
  late AnimationController _taglineController;

  late Animation<double> _bgScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;

  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Hide keyboard if coming from another screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    // Background animation
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _bgScale = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
    );
    _bgController.forward();
    _startSoundAndVibration();
    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoSlide =
        Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero).animate(
          CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
        );

    // Tagline animation
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
    );
    _taglineSlide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
        );

    _logoController.forward();
    Timer(const Duration(milliseconds: 1600), () {
      _taglineController.forward();
    });

    // Show splash + loading + then navigate

      // _showLoadingDialog(context);


       _auth.authStateChanges().listen((User? user) {
    if (user == null) {
         Future.delayed(const Duration(seconds: 2), () {
  context.go('/loginScreen');
      });

    } else {
         Future.delayed(const Duration(seconds: 2), () {
  context.go('/mainScreen');
      });

    }
  });


  }




  void _startSoundAndVibration() async {
    final player = AudioPlayer();
    bool hasVibrator = await Vibration.hasVibrator();
    bool hasAmp = await Vibration.hasAmplitudeControl();

    await player.setSource(AssetSource('sounds/1.mp3'));
    await player.resume();

    if (hasVibrator) {
      // Aggressive, punchy rhythm: 3 short bursts, 1 long pulse
      List<int> pattern = [0, 100, 75, 100, 75, 100, 100, 300,  100, 300,075,100,200,300];
      //      ↑ Start delay, then: short-pause-short-pause-short-long

      List<int>? amplitudes = hasAmp
          ? [200, 220, 240, 255] // Gradually intensifying for punch
          : null;

      if (amplitudes != null) {
        Vibration.vibrate(pattern: pattern, intensities: amplitudes);
      } else {
        Vibration.vibrate(pattern: pattern);
      }
    }
  }

  // void _showLoadingDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.black.withOpacity(0.6),
  //     builder: (_) => const fit_xLoadingDialog(),
  //   );
  // }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // AnimatedBuilder(
          //   animation: _bgScale,
          //   builder: (_, child) => Transform.scale(
          //     scale: _bgScale.value,
          //     child: child,
          //   ),
          //   child: SizedBox(
          //     width: size.width,
          //     height: size.height,
          //     child: Image.asset(
          //       'assets/logo/logo.png',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _logoSlide,
              child: FadeTransition(
                opacity: _logoOpacity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 350),
                  child: Text(
                    "FIT-X",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 2.5,
                    
                      shadows: [
                        Shadow(
                          blurRadius: 20,
                          color: Colors.white.withOpacity(0.5),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _taglineOpacity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 310),
                child: Text(
                  "Engineered for Athletes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FadeTransition(
                opacity: _taglineOpacity,
                child: Text(
                  "Made in India 🇮🇳",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

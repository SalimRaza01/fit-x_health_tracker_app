import 'dart:ui';
import 'package:fit_x/features/home/category/fitness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../home/presentation/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), FitnessScreen(), FitnessScreen()];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _pages[_currentIndex],

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1D1D),

                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 50,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildNavItem('assets/icons/home.png', "HOME", 0),
                          _buildNavItem('assets/icons/test.png', "TEST", 2),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    child: _buildNavItemMid(
                      'assets/icons/Vector.png',
                      "TRAINING",
                      1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemMid(String icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepOrangeAccent,
              const Color.fromARGB(255, 173, 45, 6),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 24, width: 24),
            SizedBox(height: 10),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.w800,
                fontSize: 10,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 2,
            width: 40,
            color: isSelected ? Colors.white : Colors.transparent,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, height: 24, width: 24),
              SizedBox(height: 10),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 300),
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
                child: Text(label),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeviceOnboarding3 extends StatefulWidget {
  const DeviceOnboarding3({super.key});

  @override
  State<DeviceOnboarding3> createState() => _DeviceOnboarding3State();
}

class _DeviceOnboarding3State extends State<DeviceOnboarding3>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _controllerripple;
  final double size = 40.0;
  final Color color = const Color.fromARGB(255, 0, 255, 8).withOpacity(0.6);

@override
void initState() {
  super.initState();

  // Slide animation for image
  _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  _slideAnimation = Tween<Offset>(
    begin: const Offset(0, 2),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ),
  );

  _controller.forward();

  // Ripple animation controller
  _controllerripple = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat();
}


  @override
  void dispose() {
    _controller.dispose();
    _controllerripple.dispose();
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
              Image.asset('assets/images/bgTexture2.png'),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: Image.asset(
                      'assets/images/onbroading3.png',
                      fit: BoxFit.fitHeight,
                      // height: 500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 290,
                right: 69,
                child: CustomPaint(
                  painter: CirclePainter(_controllerripple, color: color),
                  child: SizedBox(width: size * 3.125, height: size * 3.125),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Text(
                            'Check Pairing Mode'.toUpperCase(),
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
                            'Make sure your FIT-X band is in pairing mode. Look for a blinking green light or follow the on-screen instructions to enable pairing',
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
                 context.push('/bluetoothScreen');
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
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(this._animation, {required this.color})
    : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Save layer to support transparency
    canvas.saveLayer(rect, Paint());

    // Draw ripple waves
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }

    // Draw transparent hole in center
    final Paint clearPaint =
        Paint()
          ..blendMode = BlendMode.clear
          ..style = PaintingStyle.fill;

    canvas.drawCircle(rect.center, size.width * 0.3, clearPaint);

    // Restore layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

class PulsateCurve extends Curve {
  const PulsateCurve();

  @override
  double transform(double t) {
    if (t == 0 || t == 1) return 0.01;
    return math.sin(t * math.pi);
  }
}

import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BatteryInfoSheet extends StatelessWidget {
  const BatteryInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.backgroundLineartop,
            AppColor.backgroundLinearbottom
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "KNOW YOUR DEVICE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 50),
              // Connected + Last Sync
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CONNECTED TO",
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 10,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "FITX (H59_B304)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "LAST SYNC",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                              letterSpacing: 1.3,
                            ),
                          ),
                          Text(
                            "06:37 PM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(CupertinoIcons.arrow_2_circlepath_circle,
                          color: Colors.white54, size: 25),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Device Image + Stats
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.40,
                    child: Image.asset(
                      "assets/images/bandImage.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      spacing: 18,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        StatLine(label: "BATTERY LEVEL", value: "85%"),
                        StatLine(label: "CHARGING STATUS", value: "YES"),
                        StatLine(label: "BATTERY HEALTH", value: "GOOD"),
                        StatLine(label: "TEMPERATURE", value: "35 C"),
                        StatLine(label: "VOLTAGE", value: "3.8V"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Bottom Info
              Wrap(
                spacing: 40,
                runSpacing: 20,
                children: const [
                  BottomLine(label: "Model No.", value: "H59_B304"),
                  BottomLine(
                      label: "Uptime", value: "3 days, 4 hours, 12 minutes"),
                  BottomLine(label: "Serial No.", value: "FX2025X2-3749B829"),
                  BottomLine(label: "BUILD VER", value: "2025.0523"),
                  BottomLine(label: "FIRMWARE", value: "v1.3.7"),
                  BottomLine(
                      label: "TIMEZONE",
                      value: "GMT+5:30 / 02 June 2025, 14:15"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatLine extends StatelessWidget {
  final String label;
  final String value;
  const StatLine({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.green,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class BottomLine extends StatelessWidget {
  final String label;
  final String value;
  const BottomLine({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

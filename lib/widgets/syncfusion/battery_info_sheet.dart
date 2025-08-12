import 'package:flutter/material.dart';

class BatteryInfoSheet extends StatelessWidget {
  const BatteryInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121418),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "CONNECTED TO",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 13,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                         
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "AEROFIT BAND",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                         
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "LAST SYNC",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          letterSpacing: 1.3,
                         
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.sync, color: Colors.white54, size: 18),
                          SizedBox(width: 6),
                          Text(
                            "06:37 PM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                           
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Image + Stats Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bigger Image with rounded container & shadow
                  Container(
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2228),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Image.asset(
                      "assets/images/watch_right_render.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Stats in cards with subtle background
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ModernInfoCard(label: "Battery Level", value: "85%"),
                        SizedBox(height: 20),
                        ModernInfoCard(label: "Charging Status", value: "YES"),
                        SizedBox(height: 20),
                        ModernInfoCard(label: "Battery Health", value: "GOOD"),
                        SizedBox(height: 20),
                        ModernInfoCard(label: "Temperature", value: "35°C"),
                        SizedBox(height: 20),
                        ModernInfoCard(label: "Voltage", value: "3.8V"),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Divider(color: Colors.white12),

              const SizedBox(height: 24),

              // Bottom Info Grid - two columns
              Wrap(
                runSpacing: 18,
                spacing: 36,
                children: [
                  BottomInfoCard(label: "Model No.", value: "AF-BND-X2"),
                  BottomInfoCard(label: "Uptime", value: "3 days, 4 hours, 12 minutes"),
                  BottomInfoCard(label: "Serial No.", value: "AF2025X2-3749B829"),
                  BottomInfoCard(label: "Build Ver", value: "2025.0523"),
                  BottomInfoCard(label: "Firmware", value: "v1.3.7"),
                  BottomInfoCard(label: "Timezone", value: "GMT+5:30 / 02 June 2025, 14:15"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModernInfoCard extends StatelessWidget {
  final String label;
  final String value;

  const ModernInfoCard({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF21262E),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
             
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
             
            ),
          ),
        ],
      ),
    );
  }
}

class BottomInfoCard extends StatelessWidget {
  final String label;
  final String value;

  const BottomInfoCard({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final cardWidth = (MediaQuery.of(context).size.width / 2) - 48;
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1F27),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
              letterSpacing: 1.3,
             
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
             
            ),
          ),
        ],
      ),
    );
  }
}

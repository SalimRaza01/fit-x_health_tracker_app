
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff080B0D),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff495965), Color(0xff080B0D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 30.0,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(
                            CupertinoIcons.chevron_back,
                            color: Color(0xffBABABA),
                          ),
                        ),
                        InkWell(
                          onTap: () => context.pop(),
                          child: const Icon(
                            CupertinoIcons.square_pencil_fill,
                            color: Color(0xffBABABA),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              "assets/images/athlete1.png",
                            ),
                          ),
                          SizedBox(
                            height: 63,
                            width: 63,
                            child: CircularProgressIndicator(
                              color: Colors.greenAccent,
                              value: 0.85,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "SALIM RAZA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text(
                            "Male - 25  -  91 5555 4444",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const Text(
                            "Goal Progress - 78%",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF313D48),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/icons/watch_icon.png', height: 20),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Text(
                            "CONNECTED - 85% BATTERY",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Icon(Icons.sync, color: Colors.white, size: 18),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("78", "STRAIN", Color(0xffE39A40)),
                      _buildStat("78", "RECOVERY", Color(0xff5AB142)),
                      _buildStat("78", "SLEEP", Color(0xff5580C2)),
                    ],
                  ),

                  Row(
                    children: const [
                       Expanded(child: Divider(color: Colors.white10)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "SETTINGS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white10)),
                    ],
                  ),

                  _buildSection("DEVICE SETTINGS", [
                    "Device Connection",
                    "Firmware Update",
                    "Sync Data",
                    "Vibration Settings",
                  ]),
                  _buildSection("HELP & SUPPORT", [
                    "Contact Support",
                    "FAQs",
                    "User Guide",
                    "Report a Bug",
                  ]),
                  _buildSection("APP INFO", [
                    "App Version: 1.0.0",
                    "Terms & Conditions",
                    "Privacy Policy",
                    "Log-Out",
                    "Delete Account",
                  ]),

            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: int.parse(value) / 100,
                strokeCap: StrokeCap.round,
                strokeWidth: 4,
                color: color,
                backgroundColor: Colors.white10,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  static Widget _buildSection(String title, List<String> items) {
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Color(0xff495965), Color(0xff080B0D)],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        color: Color(0xff252C30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xff4D6171), width: 0.5),
      ),
      child: ExpansionTile(
   
        minTileHeight: 40,
        collapsedIconColor: Colors.grey,
        iconColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        children:
            items
                .map(
                  (item) => ListTile(
                    title: Text(
                      item,
                      style: TextStyle(
                        color:
                            item.contains("Delete") || item.contains("Log-Out")
                                ? Colors.redAccent
                                : Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                )
                .toList(),
      ),
    );
  }
}

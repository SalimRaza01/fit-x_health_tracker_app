import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final uid = _auth.currentUser?.uid;

    return Scaffold(
      backgroundColor: Color(0xff080B0D),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff495965),
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Color(0xffBABABA),
          ),
        ),
        title: Text(
          "PROFILE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          InkWell(
            onTap: () => context.pop(),
            child: SvgPicture.asset('assets/icons/editprofile.svg'),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection('users').doc(uid).get(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!asyncSnapshot.hasData || !asyncSnapshot.data!.exists) {
              return const Center(
                  child: Text('No user data found',
                      style: TextStyle(color: Colors.white)));
            }

            final data = asyncSnapshot.data!.data() as Map<String, dynamic>;

            final name = data['name'] ?? 'Unknown';
            final gender = data['gender'] ?? '-';
            final age = data['age']?.toString() ?? '-';
            final phone = data['phone'] ?? '-';

            return Container(
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
                                Text(
                                  '$name'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$gender - $age - $phone",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                 Text(
                                  "Goal Progress - 78%".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                              Image.asset('assets/icons/watch_icon.png',
                                  height: 20),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text(
                                  "CONNECTED - 85% BATTERY",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
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
                        _buildSection(context, "DEVICE SETTINGS", [
                          "Device Connection",
                          "Firmware Update",
                          "Sync Data",
                          "Vibration Settings",
                        ]),
                        _buildSection(context, "HELP & SUPPORT", [
                          "Contact Support",
                          "FAQs",
                          "User Guide",
                          "Report a Bug",
                        ]),
                        _buildSection(context, "APP INFO", [
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
            );
          }),
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

  Widget _buildSection(BuildContext context, String title, List<String> items) {
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
        children: items
            .map(
              (item) => ListTile(
                title: Text(
                  item,
                  style: TextStyle(
                    color: item.contains("Delete") || item.contains("Log-Out")
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
                onTap: () async {
                  if (item.contains("Log-Out")) {
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xff252C30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: const Text(
                            "Confirm Logout",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          content: const Text(
                            "Are you sure you want to log out?",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel",
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Log Out",
                                  style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await _auth.signOut();
                      context.go('/splashScreen');
                    }
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

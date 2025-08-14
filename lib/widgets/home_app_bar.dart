import 'package:fit_x/widgets/battery_info_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'calender_tile.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void _showBatterySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BatteryInfoSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                context.push('/profileScreen');
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 5, left: 10),
                child: CircleAvatar(
                  radius: 17,
                  backgroundImage: AssetImage("assets/images/athlete1.png"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: CalenderTile(),
            ),
            InkWell(
       onTap: () {
         _showBatterySheet(context);
       },
              child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 5, right: 10),
                child: Image.asset("assets/icons/watch_icon.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

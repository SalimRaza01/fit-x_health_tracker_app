import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'calender_tile.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});


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
                     const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 5, left: 10),
              child: CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage("assets/images/athlete1.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

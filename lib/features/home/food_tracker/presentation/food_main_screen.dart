import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class FoodMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundLineartop,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.backgroundLineartop,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Color(0xffBABABA),
          ),
        ),
        title: Text(
          "FOOD LOGS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.backgroundLineartop,
              AppColor.backgroundLinearbottom
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                        border: Border.all(color: AppColor.borderColor),
                  color: AppColor.universalGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: CircularProgressIndicator(
                            value: 490 / 1450,
                            strokeWidth: 3,
                            backgroundColor: Colors.grey[800],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        SvgPicture.asset('assets/icons/spoonicon.svg'),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "490 of 1450",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Cal Eaten",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Today's Logs
              const Text(
                "Today's Logs",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),

              MealLogCard(
                time: "09:30 AM",
                title: "Breakfast",
                totalCal: 490,
                targetCal: 362,
                items: [
                  MealItem(name: "Full Cream Milk", qty: "400ml", cal: 245),
                  MealItem(name: "Full Cream Milk", qty: "400ml", cal: 245),
                ],
              ),

              MealLogCard(
                time: "01:30 PM",
                title: "Lunch",
                totalCal: 490,
                targetCal: 362,
                items: [
                  MealItem(name: "Full Cream Milk", qty: "400ml", cal: 245),
                  MealItem(name: "Full Cream Milk", qty: "400ml", cal: 245),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MealLogCard extends StatelessWidget {
  final String time;
  final String title;
  final int totalCal;
  final int targetCal;
  final List<MealItem> items;

  const MealLogCard({
    required this.time,
    required this.title,
    required this.totalCal,
    required this.targetCal,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time
        Container(
          width: 70,
          child: Text(
            time,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.borderColor),
              color: AppColor.universalGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Calories
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/foodlog.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: '$totalCal ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                    children: <TextSpan>[
                      TextSpan(
                          text: '/ $targetCal',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textGrey,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: ' Cal Eaten',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textGrey,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Items
                for (var item in items) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.name}\n${item.qty}",
                        style:
                            TextStyle(color: AppColor.textGrey, fontSize: 12),
                      ),
                      Text(
                        "${item.cal} Cal",
                        style:
                            TextStyle(color: AppColor.textGrey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MealItem {
  final String name;
  final String qty;
  final int cal;

  MealItem({required this.name, required this.qty, required this.cal});
}

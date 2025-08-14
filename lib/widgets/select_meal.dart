import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectMeal extends StatelessWidget {
  const SelectMeal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.backgroundLineartop, AppColor.backgroundLineartop],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            spacing: 20,
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
              Center(
                child: Text(
                  "SELECT MEAL TYPE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              _mealOptions(
                context,
                'Breakfast',
                '0/632 Cal',
              ),
              _mealOptions(
                context,
                'Morning Snack',
                '0/181 Cal',
              ),
              _mealOptions(
                context,
                'Lunch',
                '0/635 Cal',
              ),
              _mealOptions(
                context,
                'Evening Snack',
                '0/632 Cal',
              ),
              _mealOptions(
                context,
                'Dinner',
                '0/652 Cal',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mealOptions(BuildContext context, String mealtype, String mealValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealtype,
              style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              mealValue,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                letterSpacing: 1.3,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            context.push('/trackMeal');
          },
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.textGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

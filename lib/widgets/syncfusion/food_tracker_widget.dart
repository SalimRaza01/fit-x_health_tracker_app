import 'package:fit_x/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TrackFoodCard extends StatelessWidget {
  const TrackFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [AppColor.chartGradient1, AppColor.chartGradient2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon, Label, and Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/foodicon.png', height: 35),
                    const SizedBox(width: 8),
                    const Text(
                      'TRACK FOOD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.textGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Calorie Progress Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  'CONSUMED 546 kcal',
                  style: TextStyle(color: AppColor.textGrey),
                ),
                Text(
                  'EAT 1,450 kcal',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Progress Bar
            Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColor.universalGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 700 / 1450,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color:  Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Positioned(
                  left: (850 / 1450) * MediaQuery.of(context).size.width - 12,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 2, color: Colors.pinkAccent),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Nutrients bars
            Wrap(
              runSpacing: 12,
              spacing: 24,
              children: [
                _buildNutrientBar('Protein', 0),
                _buildNutrientBar('Fat', 0),
                _buildNutrientBar('Carbs', 0),
                _buildNutrientBar('Fibre', 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientBar(String label, double percent) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${(percent * 100).toInt()}%',
            style:  TextStyle(color: AppColor.textGrey),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: AppColor.universalGrey,
            color: Colors.grey.shade400,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

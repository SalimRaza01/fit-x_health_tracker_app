import 'package:flutter/material.dart';
import 'package:fit_x/core/services/hive_db_utils.dart';

class TargetWeightScreen extends StatefulWidget {
  const TargetWeightScreen({super.key});

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  final TextEditingController _controller = TextEditingController(text: '42.7');
  final HiveDbHelper _hiveDb = HiveDbHelper();

  bool isKg = true;
  double? height;
  double? weight;
  double? bmi;
  double? idealMin;
  double? idealMax;
  double? bodyFat; // %
  int? age;
  String? gender;

  @override
  void initState() {
    super.initState();
    loadDataFromHive();
  }

  Future<void> loadDataFromHive() async {
    height = _hiveDb.getDouble('myHeight');
    weight = _hiveDb.getDouble('myWeight');
    gender = _hiveDb.getString('gender');
    String? dobStr = _hiveDb.getString('dob');

    if (dobStr != null && dobStr.isNotEmpty) {
      DateTime dob = DateTime.parse(dobStr);
      DateTime today = DateTime.now();
      age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age = age! - 1;
      }
    }

    if (height != null && weight != null && height! > 0) {
      // BMI
      bmi = weight! / (height! * height!);

      // Ideal weight range (WHO adult)
      idealMin = 18.5 * height! * height!;
      idealMax = 24.9 * height! * height!;

      // Body Fat % (Deurenberg formula)
      if (age != null && gender != null) {
        int genderNum = (gender!.toLowerCase() == "male") ? 1 : 0;
        bodyFat = (1.20 * bmi!) + (0.23 * age!) - (10.8 * genderNum) - 5.4;
      }

      // Prefill current weight
      _controller.text = weight!.toStringAsFixed(1);
    }

    setState(() {});
  }

  void saveToHive() {
    final double value = double.tryParse(_controller.text.trim()) ?? 0;
    final double storedValue = isKg ? value : value / 2.205;
    _hiveDb.putDouble('myTargetWeight', storedValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bmiText = bmi != null ? bmi!.toStringAsFixed(2) : '--';
    final bodyFatText =
        bodyFat != null ? '${bodyFat!.toStringAsFixed(1)}%' : '--';
    final rangeText =
        (idealMin != null && idealMax != null)
            ? '${idealMin!.toStringAsFixed(1)} – ${idealMax!.toStringAsFixed(1)} kg'
            : '--';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "WHAT’S YOUR TARGET  WEIGHT?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Set a realistic weight goal for yourself.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // Info Box
            Container(
              width: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D343A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black45),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/ai_robot.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Based on your BMI of "),
                          TextSpan(
                            text: bmiText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: " and body fat of "),
                          TextSpan(
                            text: bodyFatText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ", your ideal weight range is "),
                          TextSpan(
                            text: rangeText,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Weight Input
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D343A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    height: 56,
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter weight",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  isKg ? "kg" : "lbs",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Unit Toggle
            Container(
              width: 140,
              height: 44,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 220, 220),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!isKg) {
                          final double current =
                              double.tryParse(_controller.text.trim()) ?? 0;
                          final double converted = current / 2.205; // lbs → kg
                          _controller.text = converted.toStringAsFixed(1);
                        }
                        setState(() => isKg = true);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isKg ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: isKg ? Colors.white : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isKg) {
                          final double current =
                              double.tryParse(_controller.text.trim()) ?? 0;
                          final double converted = current * 2.205; // kg → lbs
                          _controller.text = converted.toStringAsFixed(1);
                        }
                        setState(() => isKg = false);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: !isKg ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'lbs',
                          style: TextStyle(
                            color: !isKg ? Colors.white : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

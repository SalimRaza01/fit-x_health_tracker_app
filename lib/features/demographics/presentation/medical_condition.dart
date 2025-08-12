// import 'package:fit_x/core/constants/app_colors.dart';
// import 'package:fit_x/core/services/hive_db_utils.dart';
// import 'package:flutter/material.dart';

// class HealthConditionsCheckbox extends StatefulWidget {
//   const HealthConditionsCheckbox({super.key});

//   @override
//   State<HealthConditionsCheckbox> createState() =>
//       _HealthConditionsCheckboxState();
// }

// class _HealthConditionsCheckboxState extends State<HealthConditionsCheckbox> {
//   final _hivedb = HiveDbHelper();
//   final Map<String, bool> _conditions = {
//     'Hypertension': false,
//     'Diabetes': false,
//     'Thyroid': false,
//     'Arthritis': false,
//     'Anxiety': false,
//     'Migraine': false,
//   };

//   double calculatedBMI = 0.0;
//   @override
//   void initState() {
//     setState(() {
//       calculatedBMI =
//           _hivedb.getDouble('myWeight') != null
//               ? _hivedb.getDouble('myWeight')!
//               : 30.0 /
//                   (_hivedb.getDouble('myHeight') != null
//                       ? _hivedb.getDouble('myHeight')!
//                       : 0.9906019812039625) *
//                   (_hivedb.getDouble('myHeight') != null
//                       ? _hivedb.getDouble('myHeight')!
//                       : 0.9906019812039625);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 40),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.0),
//             child: Text(
//               "Select Existing Conditions",
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24.0,
//               vertical: 14,
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColor.borderColor),
//                 borderRadius: BorderRadius.circular(15),
//                 gradient: LinearGradient(
//                   colors: [AppColor.chartGradient1, AppColor.chartGradient2],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Image.asset('assets/images/ai_robot.png', height: 50),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             "Based on your current weight & height,",
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.7),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             " we have calculated BMI ${calculatedBMI.toStringAsFixed(1)}",
//                             style: TextStyle(
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               fontWeight: FontWeight.w500,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           ..._conditions.entries.map((entry) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 5,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: AppColor.borderColor),
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColor.chartGradient1,
//                       AppColor.chartGradient2,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: CheckboxListTile(
//                   title: Text(
//                     entry.key,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   value: entry.value,
//                   activeColor: Colors.teal,
//                   checkColor: Colors.white,
//                   onChanged: (val) {
//                     setState(() {
//                       _conditions[entry.key] = val ?? false;
//                     });
//                   },
//                 ),
//               ),
//             );
//           }).toList(),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MedicalConditionsScreen extends StatefulWidget {
  const MedicalConditionsScreen({super.key});

  @override
  State<MedicalConditionsScreen> createState() => _MedicalConditionsScreenState();
}

class _MedicalConditionsScreenState extends State<MedicalConditionsScreen> {
  final List<String> conditions = [
    "NONE",
    "DIABETES",
    "PRE-DIABETES",
    "PCOS",
    "CHOLESTROL",
    "HYPERTENSION",
    "SLEEP ISSUE",
    "EXERCISE STRESS/ANXIETY",
    "PHYSICAL INJURY",
    "DEPRESSION",
    "ANGER ISSUE",
    "LONELINESS",
    "THYROID",
    "RELATIONSHIP STRESS",
  ];

  final Set<String> selected = {};

  void toggleCondition(String condition) {
    setState(() {
      if (condition == "NONE") {
        selected.clear();
        selected.add("NONE");
      } else {
        selected.remove("NONE");
        if (selected.contains(condition)) {
          selected.remove(condition);
        } else {
          selected.add(condition);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                 const SizedBox(height: 40),
            // Title
            const Text(
              "ANY MEDICAL CONDITION WE\nSHOULD BE AWARE OF ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                height: 1.4,
              ),
            ),
      
            const SizedBox(height: 16),
      
            const Text(
              "This info will help us guide you to your fitness\ngoals safely and quickly",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
      
            const SizedBox(height: 32),
      
            // Condition chips (scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: conditions.map((condition) {
                    final isSelected = selected.contains(condition);
                    return GestureDetector(
                      onTap: () => toggleCondition(condition),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : const Color(0xFF2C2F33),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          condition,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
      

      
         
          ],
        ),
      ),
    );
  }
}

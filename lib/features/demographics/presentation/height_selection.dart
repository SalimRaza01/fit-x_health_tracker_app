
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HeightSelection extends StatefulWidget {
  const HeightSelection({super.key});

  @override
  State<HeightSelection> createState() => _HeightSelectionState();
}

class _HeightSelectionState extends State<HeightSelection> {
  final FixedExtentScrollController _inchController =
      FixedExtentScrollController();
  final FixedExtentScrollController _cmController =
      FixedExtentScrollController();
  static const int _minInches = 39; // 3ft 3in
  final _hivedb = HiveDbHelper();

  bool isFt = false;
  int _selectedInches = 3;
  int _selectedCm = 100;
  double? heightinMeter;

  @override
  void initState() {
    super.initState();
    heightinMeter = isFt ? _selectedCm / 100 : _selectedInches / 39.37;

    _selectedInches = (_selectedCm / 2.54).round().clamp(_minInches, 95);
    _inchController.jumpToItem(_selectedInches - _minInches);
    _cmController.jumpToItem(_selectedCm - 100);
  }

  @override
  void dispose() {
    _inchController.dispose();
    _cmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
                         const SizedBox(height: 40),
      
        
              // Title
              const Center(
                child: Text(
                  "WHAT'S YOUR HEIGHT",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
        
              const SizedBox(height: 16),
        
              // Description
              const Center(
                child: Text(
                  "We’ll use your height to personalize your fitness plan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ),
        
              const SizedBox(height: 48),
          Container(
            width: 120,
            height: 40,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 220, 220, 220),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFt = false;

                        // Convert inches → cm
                     _selectedCm = (_selectedInches * 2.54).round().clamp(100, 220);
               
                        _cmController.jumpToItem(_selectedCm - 100);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: !isFt ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'cm',
                        style: TextStyle(
                          color: !isFt ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFt = true;

                        // Convert cm → inches
                        _selectedInches =( _selectedCm / 2.54).round().clamp(0, 95);
                   
                        _inchController.jumpToItem(_selectedInches);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: isFt ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'ft',
                        style: TextStyle(
                          color: isFt ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                // Vertical ruler
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 100,
                    child:
                        isFt
                            ? ListWheelScrollView.useDelegate(
                              perspective: 0.01,
                              controller: _inchController,
                              itemExtent: 20,
                              diameterRatio: 2,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  _selectedInches = index + _minInches;
                                  double cm = _selectedInches * 2.54;
                                  _selectedCm = cm.round().clamp(100, 220);
                                });
                              },

                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 95 - _minInches + 1,
                                builder: (context, index) {
                                  int inches = index + _minInches;
                                  bool isMajorTick = inches % 12 == 0;
                                  bool isMidTick =
                                      inches % 6 == 0 && !isMajorTick;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (isMajorTick)
                                        Text(
                                          "${inches ~/ 12}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        )
                                      else
                                        const SizedBox(width: 16),
                                      const SizedBox(width: 8),
                                      Container(
                                        width:
                                            isMajorTick
                                                ? 50
                                                : isMidTick
                                                ? 40
                                                : 20,
                                        height: 2,
                                        color: Colors.grey.shade500,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                            : ListWheelScrollView.useDelegate(
                              controller: _cmController,
                              itemExtent: 20,
                              perspective: 0.01,
                              diameterRatio: 3,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) async {
                                setState(()  {
                                  _selectedCm = 100 + index;
                                  double inches = _selectedCm / 2.54;
                                  _selectedInches = inches.round().clamp(0, 95);
                                  heightinMeter =
                                      isFt
                                          ? _selectedCm / 100
                                          : _selectedInches / 39.37;

                              
                                });
                                  await   _hivedb.putDouble(
                                    'myHeight',
                                    heightinMeter!,
                                  );
                              },

                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 121,
                                builder: (context, index) {
                                  int cm = 100 + index;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "$cm",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: 20,
                                        height: 2,
                                        color: Colors.grey.shade500,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                  ),
                ),

                // Center display
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: heightDisplay(),
                  ),
                ),

                // Center line
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget heightDisplay() {
    if (isFt) {
      int feet = _selectedInches ~/ 12;
      int inches = _selectedInches % 12;
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$feet",
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 2),
          const Text("ft", style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(width: 20),
          Text(
            "$inches",
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 2),
          const Text(
            "in.",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_selectedCm',
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const Text("cm", style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      );
    }
  }
}

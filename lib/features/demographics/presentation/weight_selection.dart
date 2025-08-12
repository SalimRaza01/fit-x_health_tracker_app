
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightSelection extends StatefulWidget {
  const WeightSelection({super.key});

  @override
  State<WeightSelection> createState() => _WeightSelectionState();
}

class _WeightSelectionState extends State<WeightSelection> {
  final _hivedb = HiveDbHelper();
  final FixedExtentScrollController _kgController =
      FixedExtentScrollController();
  final FixedExtentScrollController _lbController =
      FixedExtentScrollController();

  static const int _minKg = 30;
  static const int _maxKg = 150;

  bool isLb = false;
  int _selectedKg = 30;
  int _selectedLb = (30 * 2.20462).round();
  double? weightinKG;

  @override
  void initState() {
    super.initState();
    weightinKG = isLb ? _selectedLb / 2.20462 : _selectedKg.toDouble();
    _selectedLb = (_selectedKg * 2.20462).round().clamp(66, 330);
    _kgController.jumpToItem(_selectedKg - _minKg);
    _lbController.jumpToItem(_selectedLb - 66); // min lb 66 ~ 30kg
  }

  @override
  void dispose() {
    _kgController.dispose();
    _lbController.dispose();
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
                  "WHAT'S YOUR WEIGHT",
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
                  "We’ll use your weight to personalize your fitness plan.",
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
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLb = false;
                          _selectedKg = (_selectedLb / 2.20462).round().clamp(
                            _minKg,
                            _maxKg,
                          );
                          _kgController.jumpToItem(_selectedKg - _minKg);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: !isLb ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: !isLb ? Colors.white : Colors.grey,
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
                          isLb = true;
                          _selectedLb = (_selectedKg * 2.20462).round().clamp(
                            66,
                            330,
                          );
                          _lbController.jumpToItem(_selectedLb - 66);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isLb ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'lbs',
                          style: TextStyle(
                            color: isLb ? Colors.white : Colors.grey,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 100,
                      child:
                          isLb
                              ? ListWheelScrollView.useDelegate(
                                controller: _lbController,
                                itemExtent: 20,
                                perspective: 0.01,
                                diameterRatio: 2,
                                physics: const FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedLb = 66 + index;
                                    _selectedKg = (_selectedLb / 2.20462)
                                        .round()
                                        .clamp(_minKg, _maxKg);
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 265, // 330 - 66 + 1
                                  builder: (context, index) {
                                    int lb = 66 + index;
                                    bool isMajorTick = lb % 10 == 0;
                                    bool isMidTick = lb % 5 == 0 && !isMajorTick;
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (isMajorTick)
                                          Text(
                                            "$lb",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          )
                                        else
                                          const SizedBox(width: 30),
                                        const SizedBox(width: 8),
                                        Container(
                                          width:
                                              isMajorTick
                                                  ? 50
                                                  : isMidTick
                                                  ? 35
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
                                controller: _kgController,
                                itemExtent: 20,
                                perspective: 0.01,
                                diameterRatio: 2,
                                physics: const FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (index) {
                                  setState(() async {
                                    _selectedKg = _minKg + index;
                                    _selectedLb = (_selectedKg * 2.20462)
                                        .round()
                                        .clamp(66, 330);
                                    setState(() {
                                      weightinKG =
                                          isLb
                                              ? _selectedLb / 2.20462
                                              : _selectedKg.toDouble();
                                    });
                                    await _hivedb.putDouble(
                                      'myWeight',
                                      weightinKG!,
                                    );
                                  });
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: _maxKg - _minKg + 1,
                                  builder: (context, index) {
                                    int kg = _minKg + index;
                                    bool isMajorTick = kg % 10 == 0;
                                    bool isMidTick = kg % 5 == 0 && !isMajorTick;
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (isMajorTick)
                                          Text(
                                            "$kg",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          )
                                        else
                                          const SizedBox(width: 30),
                                        const SizedBox(width: 8),
                                        Container(
                                          width:
                                              isMajorTick
                                                  ? 50
                                                  : isMidTick
                                                  ? 35
                                                  : 20,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Align(
                      alignment: Alignment.center,
                      child: weightDisplay(),
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
      ),
    );
  }

  Widget weightDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLb ? '$_selectedLb' : '$_selectedKg',
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          isLb ? 'lb' : 'kg',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

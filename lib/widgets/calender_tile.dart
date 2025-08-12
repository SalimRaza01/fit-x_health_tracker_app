import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderTile extends StatefulWidget {
  const CalenderTile({super.key});

  @override
  State<CalenderTile> createState() => _CalenderTileState();
}

class _CalenderTileState extends State<CalenderTile> {
  DateTime _selectedDate = DateTime.now();

  String get _label {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final diff = selected.difference(today).inDays;

    if (diff == 0) return 'Today';
    if (diff == -1) return 'Yesterday';
    if (diff == 1) return 'Tomorrow';
    return DateFormat('dd MMM').format(_selectedDate);
  }

  void _changeDate(int offset) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: offset));
    });
  }

  Future<void> _pickDate(
    BuildContext context,
    DateTime selectedDate,
    Function(DateTime) onDatePicked,
  ) async {
    DateTime? tempSelectedDate = selectedDate;

    final results = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Dialog(
            alignment: Alignment.topCenter,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(16),
            // ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 60.0, sigmaY: 10.0),
                child: Container(
                           height: 320,
                            width: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 90, 90, 90).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(182, 131, 131, 131),
                      width: 1,
                    ),
                  ),
                  child: SfDateRangePicker(
                    showActionButtons:true,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is DateTime) {
                        tempSelectedDate = args.value;
                      }
                    },
              
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSubmit: (p0) {
                            
                      Navigator.of(context).pop(tempSelectedDate);
                    
                    },
              
                    backgroundColor: Colors.transparent,
                    showNavigationArrow: true,
                    allowViewNavigation: true,
                    showTodayButton: true,
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: TextStyle(color: Colors.white),
                      todayTextStyle: TextStyle(color: Colors.amber),
                    ),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        backgroundColor: const Color.fromARGB(255, 35, 55, 65),
                        textStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Colors.transparent,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 174, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      leadingDatesDecoration: BoxDecoration(color: Colors.white),
                      leadingDatesTextStyle: TextStyle(
                        color: Color.fromARGB(255, 195, 195, 195),
                        fontSize: 16,
                      ),
                      trailingDatesTextStyle: TextStyle(
                        color: Color.fromARGB(255, 195, 195, 195),
                        fontSize: 16,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 195, 195, 195),
                        fontSize: 16,
                      ),
                      specialDatesTextStyle: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      specialDatesDecoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.3),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.orange, width: 1.0),
                      ),
                    ),
                    initialSelectedDate: DateTime.now(),
                    initialDisplayDate: DateTime.now(),
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    selectionTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    todayHighlightColor: Colors.amber,
                    selectionColor: Colors.amber,
                    rangeSelectionColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (results != null) {
      onDatePicked(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => _pickDate(context, _selectedDate, (picked) {
            setState(() {
              _selectedDate = picked;
            });
          }),
      child: Container(
        height: 25,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 48, 56, 63),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Left arrow container
            InkWell(
              onTap: () => _changeDate(-1),

              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 20,
              ),
            ),

            // Center label container
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity == null) return;
                if (details.primaryVelocity! > 0) {
                  _changeDate(-1);
                } else if (details.primaryVelocity! < 0) {
                  _changeDate(1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 77, 88),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 1.5,
                  ),
                  child: Text(
                    _label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 5),

            // Right arrow container
            InkWell(
              onTap: () => _changeDate(1),

              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

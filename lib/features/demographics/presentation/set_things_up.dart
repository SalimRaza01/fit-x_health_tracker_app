import 'package:fit_x/core/constants/app_colors.dart';
import 'package:fit_x/core/constants/theme.dart';
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SetThingsUp extends StatefulWidget {
  const SetThingsUp({super.key});

  @override
  State<SetThingsUp> createState() => _SetThingsUpState();
}

class _SetThingsUpState extends State<SetThingsUp> {
  String selectedGender = '';
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  Timer? _saveTimer;
  final _hivedb = HiveDbHelper();

  @override
  void initState() {
    super.initState();

    nameController.addListener(_onFieldChange);
    dobController.addListener(_onFieldChange);
  }

  void _onFieldChange() {
    _saveTimer?.cancel();
    if (nameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedGender.isNotEmpty) {
      _saveTimer = Timer(const Duration(seconds: 2), _saveData);
    }
  }

  void _pickDate() {
    DatePicker.showDatePicker(
      pickerTheme: DateTimePickerTheme(
          backgroundColor: AppColor.universalGrey,
          itemTextStyle: TextStyle(color: Colors.white),
          cancelTextStyle: TextStyle(color: Colors.redAccent),
          confirmTextStyle: TextStyle(color: Colors.green)),
      context,
      dateFormat: 'dd MMMM yyyy',
      initialDateTime: DateTime(2000, 1, 1),
      minDateTime: DateTime(1900, 1, 1),
      maxDateTime: DateTime.now(),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, _) {
        setState(() {
          dobController.text = DateFormat('yyyy-MM-dd').format(dateTime);
        });
      },
    );
  }

  void _saveData() {
    _hivedb.putString('name', nameController.text);
    _hivedb.putString('dob', dobController.text);
    _hivedb.putString('gender', selectedGender);
    if (dobController.text.isNotEmpty) {
      DateTime dob = DateTime.parse(dobController.text);
      int age = DateTime.now().year - dob.year;
      if (DateTime.now().month < dob.month ||
          (DateTime.now().month == dob.month && DateTime.now().day < dob.day)) {
        age--;
      }
      _hivedb.putInt('age', age);
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile saved")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "SET THINGS UP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                "Help us set up your profile to give you the most accurate recommendations. Let's begin with your height, weight, and health conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              "FULL NAME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            _buildInputField(controller: nameController),
            const SizedBox(height: 24),
            const Text(
              "DATE OF BIRTH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: _buildInputField(controller: dobController),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "GENDER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _genderButton("MALE"),
                const SizedBox(width: 16),
                _genderButton("FEMALE"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller}) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: darkInputDecor(),
      ),
    );
  }

  Widget _genderButton(String gender) {
    final isSelected = selectedGender == gender;
    return Expanded(
      child: SizedBox(
        height: 45,
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = gender;
            });
            _onFieldChange();
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white24 : const Color(0xFF1F2225),
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                gender,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

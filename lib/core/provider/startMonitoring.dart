import 'package:flutter/material.dart';

class Startmonitoring extends ChangeNotifier {
  bool? status;
  bool get started => status!;

  void updatestatus(bool started) {
    status = started;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _appmProvider = false;
  int _hour = 0;
  int _min = 0;

  String _title = 'ADD ALARM';

  bool get appmProvider => _appmProvider;
  int get hour => _hour;
  int get min => _min;

  String get title => _title;

  void updateTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void updateHour(int value) {
    _hour = value;
    notifyListeners();
  }

  void updateMin(int value) {
    _min = value;
    notifyListeners();
  }

  void setTimeOfDay(bool time) {
    _appmProvider = time;
    notifyListeners();
  }
}

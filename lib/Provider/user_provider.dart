import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _appmProvider = false;

  bool get appmProvider => _appmProvider;

  void setTimeOfDay(bool time) {
    _appmProvider = time;
    notifyListeners();
  }
}

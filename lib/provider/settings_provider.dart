import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider();
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }
}
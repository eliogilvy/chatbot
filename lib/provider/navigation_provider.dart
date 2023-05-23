import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  NavigationProvider();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

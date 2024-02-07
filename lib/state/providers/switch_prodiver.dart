import 'package:flutter/material.dart';

class SwitchProvider with ChangeNotifier {
  bool _isOnTimeSelected = true;

  bool get isOnTimeSelected => _isOnTimeSelected;

  void toggleList(bool value) {
    _isOnTimeSelected = value;
    notifyListeners();
  }
}

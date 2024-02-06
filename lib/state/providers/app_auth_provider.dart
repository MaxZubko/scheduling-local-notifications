import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void logout(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

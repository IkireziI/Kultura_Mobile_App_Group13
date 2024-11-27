import 'package:flutter/material.dart';

class LoginScreenProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get rememberMe => _rememberMe;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}

class SignUpScreenProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }
}

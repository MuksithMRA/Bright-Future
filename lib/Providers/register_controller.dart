import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  String? fullName;
  String? email;
  String? newPassword;
  String? confirmPassword;
  String? city;
  String? phoneNumber;
  bool isLoading = false;

  setLoadingOnchanged(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  setFullName(String? fullName) {
    this.fullName = fullName;
    notifyListeners();
  }

  setEmail(String? email) {
    this.email = email;
    notifyListeners();
  }

  setNewPassword(String? newPassword) {
    this.newPassword = newPassword;
    notifyListeners();
  }

  setConfirmPassword(String? confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }

  setCity(String? city) {
    this.city = city;
    notifyListeners();
  }

  setPhoneNumber(String? phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }
}

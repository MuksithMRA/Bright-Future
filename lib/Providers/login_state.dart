import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isLoading = false;
  String? email;
  String? password;

  emailOnChanged(String? email) {
    this.email = email;
    notifyListeners();
  }

  passwordOnChanged(String? password) {
    this.password = password;
    notifyListeners();
  }

  Future<void> checkLoginState() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
        notifyListeners();
      } else {
        isLoggedIn = true;
        notifyListeners();
      }
    });
  }

  loadingOnChanged(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}

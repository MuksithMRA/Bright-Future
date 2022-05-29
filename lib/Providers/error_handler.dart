import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ErrorHandler extends ChangeNotifier {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  static String? message;
  static bool? isError;

  static void setError({required bool i, required String m}) {
    message = m;
    isError = i;
  }
}

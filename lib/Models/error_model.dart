import 'package:firebase_auth/firebase_auth.dart';

class ErrorModel {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  bool isError;
  String message;
  ErrorModel({
    required this.isError,
    required this.message,
  });
}

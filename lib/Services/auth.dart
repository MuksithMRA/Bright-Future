import 'package:brightfuture/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Providers/error_handler.dart';
import 'Database/user_handeling.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

//Register in using email pass
  Future<bool> registerWithEmailPassword({
    required AppUser user,
    required String password,
    required ErrorHandler errorHandler,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      UserHandling.adduser(
        user: user,
        uid: userCredential.user!.uid,
      );
      ErrorHandler.setError(i: false, m: "Registered Successfully");

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ErrorHandler.setError(i: true, m: "Weak Password");
        debugPrint("Error" + ErrorHandler.message.toString());
      } else if (e.code == "email-already-in-use") {
        ErrorHandler.setError(
            i: true, m: 'The account already exists for that email.');
        debugPrint("Error" + ErrorHandler.message.toString());
      }
      return false;
    } catch (e) {
      ErrorHandler.setError(i: true, m: e.toString());
      debugPrint("Error" + ErrorHandler.message.toString());
      return false;
    }
  }

//Sign in using email pass
  Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
    required ErrorHandler errorHandler,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(userCredential.user!.uid);
      ErrorHandler.setError(i: false, m: "Login success");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        ErrorHandler.setError(i: true, m: 'No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        ErrorHandler.setError(
            i: true, m: 'Wrong password provided for that user.');

        return false;
      } else {
        debugPrint(e.toString());
        ErrorHandler.setError(i: true, m: e.code);
      }

      return false;
    } catch (e) {
      debugPrint(e.toString());
      ErrorHandler.setError(i: true, m: e.toString());
      return true;
    }
  }
}

//Add User



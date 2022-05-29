import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  Future<void> uploadFile(String filePath, String fileName , String cloudPath) async {
    File file = File(filePath);

    try {
      await storage.ref(cloudPath).putFile(file);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getFile(String folder , String fileName) async {
    firebase_storage.Reference result =
        storage.ref(folder).child(fileName);

    String url = await result.getDownloadURL().then((value) {
      return value.toString();
    }).catchError((error, stackrace) {
      debugPrint("error : $stackrace");
    });
    return url;
  }
}

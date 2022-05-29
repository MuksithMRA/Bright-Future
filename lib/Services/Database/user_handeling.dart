import 'package:brightfuture/Models/user.dart';
import 'package:brightfuture/Models/user_data.dart';
import 'package:brightfuture/constant/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHandling {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  static Future<void> adduser(
      {required AppUser user, required String uid}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(uid)
        .set({
          'fullName': user.name,
          'email': user.email,
          'city': user.city,
          'phoneNumber': user.phoneNumber,
          'uid': uid,
          'photoUrl': dp,
        })
        .then((val) => debugPrint("User Added"))
        .catchError((error) => debugPrint(error.toString()));
  }

  static Stream<UserData> getCurrentUserDetails() async* {
    yield* _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .map((snap) => UserData.fromMap(snap.data() ?? {}));
  }

  static Future<void> updateUser(String title, String? subtitle) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({title: subtitle});
  }

  static Future<void> addImageUrl(String url) async {
    await _auth.currentUser?.updatePhotoURL(url).then((value) async {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({"photoUrl": url});
    }).catchError((error, stackrace) {
      debugPrint(stackrace);
    });
  }

  static Stream<QuerySnapshot> getUserFieldValue(String? docId) async* {
    yield* _firestore
        .collection('users')
        .where('uid', isEqualTo: docId)
        .limit(1)
        .snapshots();
  }

  static Stream<List<UserData>> getThisUser() {
    return _users
        .where('uid', isEqualTo: _auth.currentUser?.uid)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs
            .map((DocumentSnapshot snapshot) =>
                UserData.fromMap(snapshot.data() as Map<String, dynamic>))
            .toList());
  }
}

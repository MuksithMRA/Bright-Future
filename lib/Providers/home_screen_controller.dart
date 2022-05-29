import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Models/post.dart';
import '../Models/post_with_ref.dart';
import '../Models/user_data.dart';
import '../Services/Database/post_handeling.dart';
import '../Services/Database/user_handeling.dart';

class HomeScreenController extends ChangeNotifier {
  List<PostWithRef> posts = [];
  List<PostWithRef> foundData = [];
  UserData? user;
  String? searchText;

  loadPosts(AsyncSnapshot<QuerySnapshot> snapshot) {
    posts = snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      getUser(document.get('postedBy'));
      return PostWithRef(
        post: Post.fromMap(data),
        ref: document.id,
        user: user,
      );
    }).toList();
  }

  loadAllPosts() async {
    try {
      posts = await PostHandling.getAllPost().then((QuerySnapshot snapshot) {
        return snapshot.docs.map((QueryDocumentSnapshot documentSnapshot) {
          Map<String, dynamic> data =
              documentSnapshot.data()! as Map<String, dynamic>;
          getUser(documentSnapshot.get('postedBy'));
          return PostWithRef(
            post: Post.fromMap(data),
            ref: documentSnapshot.id,
            user: user,
          );
        }).toList();
      });

      foundData = posts;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  searchPosts(String? text) {
    notifyListeners();
    if (text != null) {
      foundData = posts.where((PostWithRef postWithRef) {
        return postWithRef.user?.fullName
                .toLowerCase()
                .contains(text.toLowerCase()) ??
            false;
      }).toList();
    } else {
      foundData = posts;
    }
  }

  getUser(String uid) async {
    UserHandling.getUserFieldValue(uid).listen((QuerySnapshot snapshot) {
      user = UserData.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
    });
  }

  chipOnClick(String? postType) {
    if (postType != null) {
      foundData = posts
          .where((PostWithRef postref) => postref.post.postType == postType)
          .toList();
    } else {
      foundData = posts;
    }
    notifyListeners();
  }
}

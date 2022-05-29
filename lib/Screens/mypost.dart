
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/post.dart';
import '../Models/screen_size.dart';
import '../Providers/my_post_controller.dart';
import '../Services/Database/post_handeling.dart';
import '../Widgets/Custom App Bar/custom_app_bar.dart';
import '../Widgets/CustomDrawer/drawer.dart';
import '../Widgets/CustomText/custom_text.dart';
import '../Widgets/Post Widget/post_widget.dart';
import '../Widgets/loading.dart';

class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPostController>(
      builder: (context, ctrl, child) {
        return Scaffold(
            drawer: const CustomDrawer(),
            appBar: customAppBar(title: "My Posts", context: context),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CustomText(title: "Post Type  : "),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.height * 0.01,
                          horizontal: ScreenSize.width * 0.045),
                      child: DropdownButton(
                        value: ctrl.dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: ctrl.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          ctrl.setPostType(newValue);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: PostHandling.getPosts(
                        postType: ctrl.dropdownvalue,
                        uid: FirebaseAuth.instance.currentUser?.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      int length = snapshot.data?.docs.length ?? 0;
                      if (snapshot.hasError) {
                        return Text('Something went wrong ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      if (length <= 0) {
                        return const Center(
                          child: CustomText(title: "No Posts"),
                        );
                      }

                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return EntirePost(
                            post: Post.fromMap(data),
                            ref: document.id,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
}

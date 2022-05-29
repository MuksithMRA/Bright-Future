import 'package:brightfuture/Models/user_data.dart';

import 'post.dart';

class PostWithRef {
  Post post;
  String ref;
  UserData? user;
  PostWithRef({
    required this.post,
    required this.ref,
     this.user,
  });
}

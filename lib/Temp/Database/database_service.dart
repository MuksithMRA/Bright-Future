import 'package:brightfuture/Models/post.dart';
import 'package:brightfuture/Models/user.dart';
import 'package:brightfuture/constant/image.dart';

class DatabaseService {
  static List<AppUser> appUsers = [
    AppUser(
        imgPath: avatar,
        name: "Nimal Perera",
        city: "Colombo",
        email: "nimal@gmail.com",
        phoneNumber: "0776675448"),
    AppUser(
        imgPath: avatar,
        name: "Saman Kumara",
        city: "Galle",
        email: "saman@gmail.com",
        phoneNumber: "0754875489"),
  ];
  static List<Post> posts = [];
}

import 'dart:io';
import 'package:brightfuture/Screens/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Models/drawer_tile.dart';
import '../Screens/about_us.dart';

import '../Screens/home.dart';
import '../Screens/mypost.dart';

class DrawerTileChange extends ChangeNotifier {
  List<DrawerTileModel> drawerTileData = [
    DrawerTileModel(icon: FontAwesomeIcons.home, title: "Home"),
    DrawerTileModel(icon: FontAwesomeIcons.newspaper, title: "My Posts"),
    DrawerTileModel(icon: FontAwesomeIcons.question, title: "FAQ"),
    DrawerTileModel(icon: FontAwesomeIcons.userFriends, title: "About us"),
    DrawerTileModel(icon: FontAwesomeIcons.shareAlt, title: "Share"),
    DrawerTileModel(icon: FontAwesomeIcons.signOutAlt, title: "Exit"),
  ];
  onTileTapped({required int index, required BuildContext context}) {
    for (var tile in drawerTileData) {
      if (tile.isTapped) {
        tile.isTapped = false;
        notifyListeners();
      }
    }

    var item = drawerTileData[index];
    item.isTapped = !item.isTapped;
    notifyListeners();

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Home()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MyPost()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FAQScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AboutUs()));
        break;
      case 4:
        share();
        break;
      case 5:
        exit(0);
      default:
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Bright Future App 😍',
      text: 'Hello , Download this  app from here 😍👉\n',
      linkUrl: 'https://irix.solutions/',
      chooserTitle: 'Share Bright Future App with',
    );
  }

  onLaunch() {
    drawerTileData[0].isTapped = true;
  }
}

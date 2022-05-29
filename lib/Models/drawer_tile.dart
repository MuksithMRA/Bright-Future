import 'package:flutter/cupertino.dart';

class DrawerTileModel {
  IconData icon;
  String title;
  bool isTapped;
  DrawerTileModel({
    required this.icon,
    required this.title,
     this.isTapped = false,
  });
}

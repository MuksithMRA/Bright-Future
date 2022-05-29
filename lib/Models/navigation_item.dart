import 'package:flutter/cupertino.dart';

class NavigationItem {
  String label;
  IconData icon;
  Widget route;
  NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

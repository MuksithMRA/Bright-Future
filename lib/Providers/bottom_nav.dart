import 'package:flutter/material.dart';
import '../Models/navigation_item.dart';
import '../Screens/home_screen.dart';
import '../Screens/profile_screen.dart';

class BottomNav extends ChangeNotifier {
  int currentIndex = 0;

  onChange(int val) {
    currentIndex = val;
    notifyListeners();
  }

  List<NavigationItem> navItems = [
    NavigationItem(
        label: "All Posts", icon: Icons.explore, route: const HomeScreen()),
    NavigationItem(
      label: "Profile",
      icon: Icons.person,
      route: const ProfileScreen(),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Views/Profile.dart';
import '../Views/HomeScreen.dart';

class Consts {
  static final navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Color.fromARGB(255, 28, 168, 96),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.compare_arrows),
      title: const Text("Echange"),
      selectedColor: Color.fromARGB(255, 102, 138, 217),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.account_circle),
      title: const Text("Profile"),
      selectedColor: Color.fromARGB(255, 233, 175, 27),
    ),
  ];
  static void onItemTapped(BuildContext context,int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Profile(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Profile(),
          ),
        );
        break;
      case 2:

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  Profile(),
          ),
        );
        break;
    }
  }
}
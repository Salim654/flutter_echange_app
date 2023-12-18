import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Views/AddProductScreen.dart';
import '../Views/Profile.dart';
import '../Views/HomeScreen.dart';
import '../Views/MyProducts.dart';

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

 List<Category> categories = [
  Category(
    name: 'Pour la Maison et Jardin',
    icon: Icons.home, // Replace with the actual icon
  ),
  Category(
    name: 'Véhicules',
    icon: Icons.car_crash, // Replace with the actual icon
  ),
  Category(
    name: 'Habillement et Bien Etre',
    icon: Icons.shopping_basket, // Replace with the actual icon
  ),
  Category(
    name: 'Informatique et Multimedias',
    icon: Icons.smartphone, // Replace with the actual icon
  ),
   Category(
    name: 'Loisirs et Divertissement',
    icon: Icons.sports, // Replace with the actual icon
  ),
  Category(
    name: 'Immobilier',
    icon: Icons.home_outlined, // Replace with the actual icon
  ),
  // Add more categories as needed
];

class Consts {
  static final navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Accueil"),
    selectedColor: Color.fromARGB(255, 28, 168, 96),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.compare_arrows),
    title: const Text("Mes Produits"),
    selectedColor: Color.fromARGB(255, 102, 138, 217),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.account_circle),
    title: const Text("Profile"),
    selectedColor: Color.fromARGB(255, 233, 175, 27),
  ),
];


  static List<Category> categories = [
    Category(
      name: 'Pour la Maison et Jardin',
      icon: Icons.home, // Replace with the actual icon
    ),
    Category(
      name: 'Véhicules',
      icon: Icons.car_crash, // Replace with the actual icon
    ),
    Category(
      name: 'Habillement et Bien Etre',
      icon: Icons.shopping_basket, // Replace with the actual icon
    ),
    Category(
      name: 'Informatique et Multimedias',
      icon: Icons.smartphone, // Replace with the actual icon
    ),
    Category(
      name: 'Loisirs et Divertissement',
      icon: Icons.sports, // Replace with the actual icon
    ),
    Category(
      name: 'Immobilier',
      icon: Icons.home_outlined, // Replace with the actual icon
    ),
    // Add more categories as needed
  ];

  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyProducts()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddProductScreen()),
        );
        break;
    }
  }
}

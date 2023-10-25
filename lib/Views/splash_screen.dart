import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_page/Views/HomeScreen.dart';
import 'package:flutter_simple_page/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/size_config.dart';

class PageSplashScreen extends StatefulWidget {
  const PageSplashScreen({Key? key}) : super(key: key);

  @override
  State<PageSplashScreen> createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null && token.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PageLogin(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.teal.shade500,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash.png', // Replace with your image asset
              width: getProportionateScreenWidth(200), // Adjust the width as needed
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              "Haya Nbadlou",
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

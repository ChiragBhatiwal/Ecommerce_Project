import 'dart:async';

import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/BottomNavigation_MainScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/Flutter_Storage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool _isFirstLaunch = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      await checkToken(); // Ensure checkToken is awaited before continuing
      _checkIfFirstLaunch();
    });
  }

  _checkIfFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // If it's the first launch, set it to false after showing the splash
      prefs.setBool('isFirstLaunch', false);
      setState(() {
        _isFirstLaunch = true;
      });
    } else {
      // If it's not the first launch, navigate directly to the home screen
      if (!mounted)
        return; // Ensure the widget is still mounted before navigating
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
      });
    }

    if (_isFirstLaunch) {
      // If it's the first launch, navigate after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Splash Screen"),
    ));
  }

  Future<void> checkToken() async {
    String? data = await FlutterStorage().readData();
    if (data != null) {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }
}

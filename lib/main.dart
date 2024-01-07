import 'package:flutter/material.dart';
import 'package:toku/screens/login.dart';
import 'package:toku/screens/onboarding.dart';
import 'package:toku/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
        
    );
  }
}


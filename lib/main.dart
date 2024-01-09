import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toku/auth/splash.dart';
import 'package:toku/firebase_options.dart';
import 'package:toku/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: StreamBuilder(
      //       stream: FirebaseAuth.instance.authStateChanges(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData && context.mounted) {
      //           return const Home();
      //         } else {
      //           return const SplashScreen();
      //         }
      //       }),
      // ),
      home: SplashScreen(),
    );
  }
}

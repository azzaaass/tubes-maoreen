import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toku/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Onboarding())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xfff1a073), Color(0xffff6b4a)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset("assets/images/logo.png"),
            )
          ],
        ),
      ),
    );
  }
}

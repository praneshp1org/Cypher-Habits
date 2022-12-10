import 'package:easy_splash_screen/easy_splash_screen.dart';
// import '../home.dart';
import 'package:flutter/material.dart';
import 'package:habittrackertute/pages/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 50,
      logo: Image.asset(
          'assets/logo.png'),
      title: Text(
        "Cypher Habits",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: HomePage(),
      durationInSeconds: 5,
    );
  }
}
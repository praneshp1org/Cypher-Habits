import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habittrackertute/pages/home_page.dart';
import 'package:habittrackertute/pages/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // initialize hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("Habit_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cypher Habits',
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
    );
  }
}

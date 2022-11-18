import 'package:flutter/material.dart';
import 'package:habittrackertute/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
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
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
    );
  }
}

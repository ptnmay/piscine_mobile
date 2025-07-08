import 'package:flutter/material.dart';
import 'ex00/ex00.dart';
import 'ex01/ex01.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget getExercise(int index) {
    switch (index) {
      case 0:
        return const Ex00();
      case 1:
        return const Ex01();
      default:
        throw Exception('Invalid exercise index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "weather_app",
      debugShowCheckedModeBanner: false,
      home: getExercise(0),
      // home: getExercise(1),
    );
  }
}
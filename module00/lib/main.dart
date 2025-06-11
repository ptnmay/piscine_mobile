import 'package:flutter/material.dart';
import 'ex00/ex00.dart';
import 'ex01/ex01.dart';
import 'ex02/ex02.dart';
import 'ex03/ex03.dart';

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
      case 2:
        return const Ex02();
      case 3:
        return const Ex03();
      default:
        throw Exception('Invalid exercise index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: getExercise(0),
      // home: getExercise(1),
      // home: getExercise(2),
      home: getExercise(3),
    );
  }
}
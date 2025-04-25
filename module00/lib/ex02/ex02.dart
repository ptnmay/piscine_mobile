import 'package:flutter/material.dart';
import 'package:module00/ex02/calculator_screen.dart';

class Ex02 extends StatelessWidget {
  const Ex02({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const CalculatorScreen());
     // Calls the UI screen
  }
}
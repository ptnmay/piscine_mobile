import 'package:flutter/material.dart';
import 'package:module00/ex03/calculator_screen.dart';

class Ex03 extends StatelessWidget {
  const Ex03({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const CalculatorScreen());
     // Calls the UI screen
  }
}
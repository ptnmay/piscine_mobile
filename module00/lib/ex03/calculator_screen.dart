// import 'package:ex02/button_values.dart';
// import 'package:flutter/material.dart';
// import 'package:math_expressions/math_expressions.dart';


// class CalculatorScreen extends StatefulWidget {
//   const CalculatorScreen({super.key});

//   @override
//   State<CalculatorScreen> createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {

//   String expression = "";


//   @override
// Widget build(BuildContext context) {
//   // final screenSize = MediaQuery.of(context).size;
//   final orientation = MediaQuery.oaf(context).orientation;

//   return Scaffold(
//     appBar: AppBar(
//       title: const Center(child: Text("Calculator")),
//       backgroundColor: Colors.amber,
//       foregroundColor: Colors.black,
//     ),
//     body: SafeArea(
//       child: Column(
//         children: [
//           // Display area
//           Expanded(
//             flex: orientation == Orientation.portrait ? 2 : 1,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               alignment: Alignment.bottomRight,
//               child: FittedBox(
//                 alignment: Alignment.bottomRight,
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   expression.isEmpty ? "0" : expression,
//                   style: const TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   textAlign: TextAlign.end,
//                 ),
//               ),
//             ),
//           ),

//           // Buttons grid
//           Expanded(
//             flex: 5,
//             child: GridView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: Btn.buttonValues.length,
//               physics: const NeverScrollableScrollPhysics(), // prevent scroll
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 8,
//                 childAspectRatio: orientation == Orientation.portrait ? 1 : 1.4,
//               ),
//               itemBuilder: (context, index) {
//                 final value = Btn.buttonValues[index];
//                 return buildButton(value);
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// // button
//   Widget buildButton(value) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Material(
//         color: getBtnColor(value),
//         clipBehavior: Clip.hardEdge,
//         shape: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.white24,
//           ),
//           borderRadius: BorderRadius.circular(100)),
//         child: InkWell(
//           onTap: () => onBtnTap(value),
//           child: Center(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24
//                 ),
//               ),
//             ),
//         ),
//       ),
//     );
//   }

// // void onBtnTap(String value){
// //     if (value != Btn.dot && int.tryParse(value) == null){
// //       if (op.isNotEmpty && n2.isNotEmpty) {
// //         //calualte
// //       }
// //       op = value;
// //     } else if (n1.isEmpty || op.isEmpty){
// //       if (value == Btn.dot && n1.contains(Btn.dot)){

// //       }
// //     }
// //   setState(() {
// //     n1 += value;
// //   });
// // }

// void onBtnTap(String value) {
//   setState(() {
//     // Handle 'C' (backspace) — deletes one character
//     if (value == Btn.clr) {
//       if (expression.isNotEmpty) {
//         expression = expression.substring(0, expression.length - 1);
//       }
//       return;
//     }

//     // Handle 'D' (delete) — clears the entire expression
//     if (value == Btn.del) {
//       expression = "";
//       return;
//     }

//     // Handle '=' (calculate result)
//     if (value == Btn.calculate) {
//       String exp = expression
//           .replaceAll(Btn.multiply, '*')
//           .replaceAll(Btn.divide, '/'); // Handle custom symbols like × and ÷

//       try {
//         // Use ShuntingYardParser to evaluate the expression
//         final parser = ShuntingYardParser();
//         final parsedExp = parser.parse(exp);
//         final result = parsedExp.evaluate(EvaluationType.REAL, ContextModel());

//         // Display the result
//         expression = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
//       } catch (e) {
//         expression = "Error";  // In case of any error during parsing
//       }
//       return;
//     }

//     // Prevent multiple decimal points in a number
//     if (value == Btn.dot) {
//       List<String> parts = expression.split(RegExp(r'[\+\-\*/]'));
//       if (parts.isNotEmpty && parts.last.contains('.')) return;
//     }

//     // Append the button value to the expression
//     expression += value;
//   });
// }




// //color button
//   Color getBtnColor(value) {
//     return  [Btn.del, Btn.clr].contains(value)
//         ?Colors.blueGrey
//         :[
//           Btn.per, 
//           Btn.multiply,
//           Btn.add,
//           Btn.subtract,
//           Btn.divide,
//           Btn.calculate
//           ].contains(value)
//           ?Colors.orange
//           :Colors.black87;
//   }
// }
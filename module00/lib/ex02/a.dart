import 'package:flutter/material.dart';
import 'package:module00/ex02/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "0"; // Default expression value
  String result = "0";     // Default result value

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Dynamically calculate font size based on screen width
    double displayFontSize = screenWidth / 30;

    // Adjust the button grid size based on screen width and orientation
    int crossAxisCount = orientation == Orientation.portrait ? 4 : 4;

    // Adjusting child aspect ratio for better fitting on large screens
    double childAspectRatio = (screenWidth - 32) / (screenHeight * 0.4);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calculator")),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🟡 Expression TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                controller: TextEditingController(text: expression),
                readOnly: true,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: displayFontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white24
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Expression",
                ),
              ),
            ),

            // 🟢 Result TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: TextField(
                controller: TextEditingController(text: result),
                readOnly: true,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: displayFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Result",
                ),
              ),
            ),

            // 🟠 Buttons grid
            Expanded(
              flex: 5,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: Btn.buttonValues.length,
                    physics: const NeverScrollableScrollPhysics(), // Prevent scroll
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Adjust based on orientation
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: childAspectRatio, // Ensure buttons fit well
                    ),
                    itemBuilder: (context, index) {
                      final value = Btn.buttonValues[index];
                      return buildButton(value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🟠 Build the button UI
  Widget buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20, // You can adjust this size as necessary
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Button tap logic
  void onBtnTap(String value) {
    debugPrint("Button pressed: $value");
  }

  // Button color logic
  Color getBtnColor(String value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}


//deep
// import 'package:flutter/material.dart';
// import 'package:module00/ex02/button_values.dart';

// class CalculatorScreen extends StatefulWidget {
//   const CalculatorScreen({super.key});

//   @override
//   State<CalculatorScreen> createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {
//   String expression = "";
//   String currentValue = "0";

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             _buildDisplay(),
//             _buildButtonGrid(screenSize, isPortrait),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Builds the app bar with calculator title
//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Center(child: Text("Calculator")),
//       backgroundColor: Colors.amber,
//       foregroundColor: Colors.black,
//     );
//   }

//   /// Builds the calculator display area
//   Widget _buildDisplay() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         // Previous expression display
//         Padding(
//           padding: const EdgeInsets.all(5),
//           child: Text(
//             expression.isEmpty ? '0' : expression,
//             style: const TextStyle(
//               color: Colors.white24,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         // Current value display
//         Padding(
//           padding: const EdgeInsets.all(5),
//           child: Text(
//             currentValue,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Builds the grid of calculator buttons
//   Widget _buildButtonGrid(Size screenSize, bool isPortrait) {
//     return Expanded(
//       flex: 4,
//       child: GridView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: Btn.buttonValues.length,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4, // 4 columns in both orientations
//           mainAxisSpacing: 6,
//           crossAxisSpacing: 6,
//           childAspectRatio: _calculateChildAspectRatio(screenSize, isPortrait),
//         ),
//         itemBuilder: (context, index) {
//           return _buildCalculatorButton(Btn.buttonValues[index]);
//         },
//       ),
//     );
//   }

//   /// Calculates the appropriate aspect ratio for buttons based on screen size
//   double _calculateChildAspectRatio(Size screenSize, bool isPortrait) {
//     return (screenSize.width - 32) / (screenSize.height * 0.4);
//   }

//   /// Builds an individual calculator button
//   Widget _buildCalculatorButton(String value) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Material(
//         color: _getButtonColor(value),
//         clipBehavior: Clip.hardEdge,
//         shape: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white24),
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: InkWell(
//           onTap: () => _onButtonPressed(value),
//           child: Center(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Handles button press events
//   void _onButtonPressed(String value) {
//     debugPrint("Button pressed: $value");
//     // Add your button press logic here
//     setState(() {
//       // Update expression or currentValue based on button pressed
//     });
//   }

//   /// Returns the appropriate color for each button type
//   Color _getButtonColor(String value) {
//     if ([Btn.del, Btn.clr].contains(value)) {
//       return Colors.blueGrey;
//     } else if ([
//       Btn.per,
//       Btn.multiply,
//       Btn.add,
//       Btn.subtract,
//       Btn.divide,
//       Btn.calculate
//     ].contains(value)) {
//       return Colors.orange;
//     } else {
//       return Colors.black87;
//     }
//   }
// }
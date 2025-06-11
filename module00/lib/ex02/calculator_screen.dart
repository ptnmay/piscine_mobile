import 'package:flutter/material.dart';
import 'package:module00/ex02/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Adjust the button grid size based on screen width and orientation
    int crossAxisCount = 4;

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: orientation == Orientation.portrait ? 3 : 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: FittedBox(
                  alignment: Alignment.bottomRight,
                  fit: BoxFit.scaleDown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Buttons grid
            Expanded(
              flex: 5,
              child: GridView.builder(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the button UI
  Widget buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, // You can adjust this size as necessary
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

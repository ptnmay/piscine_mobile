import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:module00/ex03/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String sum = "0";
  String ans = "0";

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    double displayFontSizeSum = screenWidth / 10;
    double displayFontSizeAns = screenWidth / 8;
    int crossAxisCount = 4;
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
            // Display area (added one more line inside)
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
                        sum,
                        style: TextStyle(
                          color: Colors.white24,
                          fontSize: displayFontSizeSum,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ans,
                        style: TextStyle(
                          fontSize: displayFontSizeAns,
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
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: childAspectRatio,
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
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(String value) {
    setState(() {
      debugPrint("Button pressed: $value");
      if (value == Btn.clr) {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
          ans = expression.isEmpty ? "0" : expression;
        }
        return;
      }

      if (value == Btn.del) {
        expression = "";
        sum = "0";
        ans = "0";
        return;
      }

      if (value == Btn.calculate) {
        String exp = expression.replaceAll(Btn.multiply, '*').replaceAll(Btn.divide, '/');
        try {
          final parser = ShuntingYardParser();
          final parsedExp = parser.parse(exp);
          final result = parsedExp.evaluate(EvaluationType.REAL, ContextModel());

          sum = expression;
          ans = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
          expression = ans;
        } catch (e) {
          sum = expression;
          ans = "Error";
          expression = "";
        }
        return;
      }

      if (value == Btn.dot) {
        List<String> parts = expression.split(RegExp(r'[\+\-\*/]'));
        if (parts.isNotEmpty && parts.last.contains('.')) return;
      }

      expression += value;
      ans = expression;
    });
  }

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

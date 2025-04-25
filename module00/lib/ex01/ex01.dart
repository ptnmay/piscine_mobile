import 'package:flutter/material.dart';

class Ex01 extends StatefulWidget {
  const Ex01({super.key});

  @override
  _Ex01State createState() => _Ex01State();
}

class _Ex01State extends State<Ex01> {
  String _displayText = 'Press the button below:';

  void _buttonPressed() {
    setState(() {
      if (_displayText == 'Press the button below:') {
        _displayText = 'Hello World!';
      } else {
        _displayText = 'Press the button below:';
      }
    });

        debugPrint("Button pressed");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_displayText),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buttonPressed,
              child: const Text('Press me'),
            ),
          ],
        ),
      ),
    );
  }
}

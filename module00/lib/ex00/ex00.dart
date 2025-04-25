import 'package:flutter/material.dart';

class Ex00 extends StatelessWidget {
  const Ex00({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('A simple text'),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  debugPrint('Button pressed');
                },
                child: const Text('Press me')),
          ],
        ),
      ),
    );
  }
}

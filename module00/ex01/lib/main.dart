import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ex00',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Track the text color
  Color _textColor = Colors.white;

  // Function to change the text color when pressed
  void _buttonPressed() {
    print('Button pressed');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 255, 248),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text widget
            Text(
              'Press the button below:',
              style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 23, 95, 92)),
            ),
            SizedBox(height: 20),
            // Button widget
            ElevatedButton(
              onPressed: _buttonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 50, 189, 187)),
              child: Text('Press me',
              style: TextStyle(color: _textColor)), // Dynamic text color
            ),
          ],
        ),
      ),
    );
  }
}

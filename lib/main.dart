import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const methodChannel = MethodChannel('com.filio.increment');

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SQLite Example For Native'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text("Increment"),
          ),
        ),
      ),
    );
  }

  Future<void> _incrementCounter() async {
    try {
      final String result = await methodChannel.invokeMethod('incrementCounter');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to increment counter: '${e.message}'.");
    }
  }
}

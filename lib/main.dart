import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const methodChannel = MethodChannel('com.filio.increment');


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;


  @override
  void initState() {
    super.initState();
    _getCurrentCounter();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SQLite Example For Native'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("Increment"),
              ),
              const SizedBox(height: 8,),
              Text("Current Value is: $_counter"),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Note that when you terminate the app, the value will increase.",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentCounter() async {
    try {
      final int result = await MyApp.methodChannel.invokeMethod('getCurrentCounter');
      setState(() {
        _counter = result;
      });
    } on PlatformException catch (e) {
      print("Failed to get current counter: '${e.message}'.");
    }
  }

  Future<void> _incrementCounter() async {
    try {
      final String result = await MyApp.methodChannel.invokeMethod('incrementCounter');
      print(result);
      _getCurrentCounter();
    } on PlatformException catch (e) {
      print("Failed to increment counter: '${e.message}'.");
    }
  }
}

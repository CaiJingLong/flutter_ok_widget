import 'package:example/examples.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OK widgets examples'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: examples.map(_buildButton).toList(),
        ),
      ),
    );
  }

  Widget _buildButton(Widget targetExampleWidget) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ),
          child: Text(targetExampleWidget.runtimeType.toString()),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => targetExampleWidget,
              ),
            );
          },
        ),
      );
    });
  }
}

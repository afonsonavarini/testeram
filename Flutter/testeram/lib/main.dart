import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Hog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryHogScreen(),
    );
  }
}

class MemoryHogScreen extends StatefulWidget {
  @override
  _MemoryHogScreenState createState() => _MemoryHogScreenState();
}

class _MemoryHogScreenState extends State<MemoryHogScreen> {
  List<Uint8List> memoryHogList = [];
  bool isConsuming = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Hog'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isConsuming ? null : _startConsumingMemory,
              child: Text('Consume Memory'),
            ),
            ElevatedButton(
              onPressed: _clearMemory,
              child: Text('Clear Memory'),
            ),
          ],
        ),
      ),
    );
  }

  void _startConsumingMemory() {
    setState(() {
      isConsuming = true;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        isConsuming = false;
      });
    });

    _consumeMemoryLoop();
  }

  void _consumeMemoryLoop() {
    if (!isConsuming) return;

    final Uint8List hogData = Uint8List(10000000); // 10 MB
    setState(() {
      memoryHogList.add(hogData);
    });

    Future.delayed(Duration(milliseconds: 10), _consumeMemoryLoop);
  }

  void _clearMemory() {
    setState(() {
      memoryHogList.clear();
    });
  }
}
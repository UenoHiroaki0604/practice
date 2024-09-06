import 'dart:convert'; // Base64デコードのため
import 'dart:typed_data'; // Uint8Listのため
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter 画像表示サンプル'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Image.network(
          'data:image/png;base64,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',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

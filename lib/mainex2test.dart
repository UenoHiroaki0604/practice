import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Timer _timer;
  bool flag = false;
  late Alignment _alignment;
  int _counter = 10;
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    _alignment = const Alignment(0.0, 0.0); // 初期位置

    if (flag) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          setState(() {
            _counter--;
            if (_counter >= 0) {
              if (_counter % 2 == 0) {
                double endx = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
                double endy = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
                _alignment = Alignment(endx, endy); // Alignment を更新
              }
            } else {
              flag = false;
              _counter = 10;
              _alignment = const Alignment(0.0, 0.0); // タイマー終了時の位置
            }
          });
        },
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // タイマーをキャンセル
    super.dispose();
  }

  void _click() {
    setState(() {
      flag = !flag;
      if (flag) {
        // タイマーの再設定
        _timer = Timer.periodic(
          const Duration(seconds: 1),
          (Timer timer) {
            setState(() {
              _counter--;
              if (_counter != 0) {
                if (_counter % 2 == 0) {
                  double endx = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
                  double endy = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
                  _alignment = Alignment(endx, endy); // Alignment を更新
                }
              } else {
                flag = false;
                _counter = 10;
                _alignment = const Alignment(0.0, 0.0); // タイマー終了時の位置
              }
            });
          },
        );
      } else {
        _timer.cancel(); // タイマーをキャンセル
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: _alignment,
              duration: const Duration(seconds: 1), // アニメーションの時間
              child: const Icon(Icons.badge_sharp, size: 100),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Text(
                _counter.toString(),
                style: const TextStyle(
                    fontSize: 32, color: Color.fromARGB(255, 68, 38, 38)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _click,
        child: const Icon(Icons.add),
      ),
    );
  }
}

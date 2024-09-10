import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final math.Random random = math.Random();
  bool flag = false;
  bool flag2 = false;
  late Timer _timer;
  // カウンター
  double startx = 0.0;
  double endx = 0.0;
  double starty = 0.0;
  double endy = 0.0;
  int _counter = 10;
  int _clickCounter = 0;
  late Alignment _alignment;

  endx = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
  endy = random.nextDouble() * 2 - 1; // -1 から 1 の範囲
  _alignment = Alignment(endx, endy); // Alignment を更新

  @override
  void initState() {
    super.initState();
    _alignment = Alignment(startx, starty);
    if (flag) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          _counter--;
          if (_counter >= 0) {
            flag2 = true;
            startx = endx;
            starty = endy;

            setState(() {});
          } else {
            flag = false;
            _counter = 10;
            startx = 0.0;
            endx = 0.0;
            starty = 0.0;
            endy = 0.0;
          }
        },
      );
    }
    ;
  }

  @override
  void dispose() {
    _timer.cancel(); // タイマーをキャンセル
    super.dispose();
  }

  _click() async {
    setState(() {
      flag = !flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: AnimatedAlign(
            alignment: _alignment,
            duration: const Duration(seconds: 1), // アニメーションの時間
            child: Icon(Icons.badge_sharp)),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: _click, child: const Icon(Icons.add)),
    );
  }
}

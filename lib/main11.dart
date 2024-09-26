import 'package:flutter/material.dart';
import 'dart:math';

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
  late AnimationController _animationController2;
  late Animation _animation;
  late Animation _animation2;
  // ボタンタップ時にフラグを切り替える
  _forward() async {
    setState(() {
      _animationController.forward();
      _animationController2.reverse();
    });
  }

  _stop() async {
    setState(() {
      _animationController.stop();
      _animationController2.stop();
    });
  }

  _reverse() async {
    setState(() {
      _animationController.reverse();
      _animationController2.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = _animationController.drive(Tween(begin: 0.0, end: 2.0 * pi));
    _animation2 = _animationController2.drive(Tween(begin: 0.0, end: 2.0 * pi));
  }

  @override
  void disporse() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Transform.rotate(
                angle: _animation.value,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXv6kYUt38ccFHgJ6Ira4XrLDAeZgQjsPooA&s",
                  width: 1000, // 画像の幅を指定
                  height: 300, // 画像の高さを指定));
                ),
              );
            }),
        AnimatedBuilder(
            animation: _animation2,
            builder: (context, _) {
              return Transform.rotate(
                  angle: _animation2.value, child: Text("宮城誕生壱百五拾周年"));
            }),
      ]),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
            onPressed: _forward, child: const Icon(Icons.arrow_forward)),
        FloatingActionButton(onPressed: _stop, child: const Icon(Icons.pause)),
        FloatingActionButton(
            onPressed: _reverse, child: const Icon(Icons.arrow_back)),
      ]),
    );
  }
}

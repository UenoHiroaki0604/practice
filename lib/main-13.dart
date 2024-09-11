import 'package:flutter/material.dart';
import './main12/tokyo.dart';
import './main12/utsunomiya.dart';
import './main12/fukushima.dart';
import './main12/sendai.dart';
import './main12/shitinohe_towada.dart';
import './main12/shinaomori.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // アプリ内のルート（ページ遷移）を定義
      // 各ルートに対して表示するウィジェット（TestPage1、TestPage2、TestPage3）を対応させる
      routes: {
        "/tokyo": (BuildContext context) => Tokyo(),
        "/utsunomiya": (BuildContext context) => Utsunomiya(),
        "/fukushima": (BuildContext context) => Fukushima(),
        "/sendai": (BuildContext context) => Sendai(),
        "/shitinohe": (BuildContext context) => ShitinoheTowada(),
        "/shinaomori": (BuildContext context) => Shinaomori(),
      },
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

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;
  final _pages = [
    Tokyo(),
    Utsunomiya(),
    Fukushima(),
    Sendai(),
    ShitinoheTowada(),
    Shinaomori(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffoldウィジェットで基本的なページの構造を作成
    // bodyに別ページ（TestPage1）を表示
    return Scaffold(
        body: PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: _pages,
    ));
  }
}

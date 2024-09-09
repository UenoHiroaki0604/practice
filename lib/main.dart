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
      home: const MyHomePage(title: 'Flutter　画面の構築　実習問題'),
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
  bool _flag = false;

  // ボタンタップ時にフラグを切り替える
  _click() async {
    setState(() {
      _flag = !_flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
              opacity: _flag ? 0.1 : 1.0,
              duration: Duration(seconds: 3),
              child: Text(
                "福岡情報校",
                style: TextStyle(
                  color: Colors.blue, // 文字色を青に設定
                  fontSize: 80, // フォントサイズを20に設定
                ),
              )),
          AnimatedAlign(
            duration: const Duration(seconds: 3),
            alignment: _flag ? Alignment.topLeft : Alignment.topRight,
            child: Image.network(
              'https://dormy-ac.com/page/o-hara-nmb/img/top/mv-title.png',
              width: 200, // 画像の幅を指定
              height: 100, // 画像の高さを指定
            ),
          )
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: _click, child: const Icon(Icons.add)),
    );
  }
}

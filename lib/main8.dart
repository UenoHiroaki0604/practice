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
            AnimatedContainer(
              duration: const Duration(seconds: 3),
              alignment: _flag ? Alignment.center : Alignment.centerRight,
              transform: _flag ? Matrix4.skewX(0.0) : Matrix4.skewX(0.3),
              child: Image.network(
                'https://www.juaa.or.jp/updata/case_study/524/2/202107151205_633197.jpg',
                width: 200, // 画像の幅を指定
                height: 100, // 画像の高さを指定
              ),
            ),
            AnimatedSwitcher(
                duration: const Duration(seconds: 3),
                child: _flag
                    ? const Text("福岡情情報",
                        style: TextStyle(
                          color: Colors.blue, // 文字色を青に設定
                          fontSize: 80,
                        ))
                    : Padding(
                        padding: const EdgeInsets.all(20.0), // マージンとして使用する
                        child: const Icon(
                          Icons.calculate,
                          color: Color.fromARGB(255, 66, 132, 255),
                          size: 100, // アイコンのサイズを指定
                        ),
                      )),
          ]),
      floatingActionButton:
          FloatingActionButton(onPressed: _click, child: const Icon(Icons.add)),
    );
  }
}

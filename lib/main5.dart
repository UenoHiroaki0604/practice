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
  String _text = "";
  String _logoUrl = "";
  Color _color = Colors.white;

  void _ClickTextButton() {
    setState(() {
      _text = "テキストボタンクリック";
      _color = const Color.fromARGB(255, 96, 74, 1);
      return;
    });
  }

  void _ClickFloatingActionButton() {
    setState(() {
      _text = "FloatingActionButtonクリック";
      _color = const Color.fromARGB(255, 233, 61, 249);
      return;
    });
  }

  void _ClickElevatedButton({required String icon, required Color color}) {
    setState(() {
      _text = "$iconボタンクリック";
      _color = color;
      return;
    });
  }

  void _ClickTextButton2(String langicon) {
    setState(() {
      _logoUrl = langicon;
      return;
    });
  }

  Uint8List _decodeBase64(String base64String) {
    final bytes = base64Decode(base64String.split(',').last);
    return Uint8List.fromList(bytes);
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
        children: [
          const Text("HelloWorld"),
          const Text("ハローワールド"),
          TextButton(
            onPressed: _ClickTextButton,
            child: const Text("テキストボタン"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 角丸を適用
                  ),
                ),
                onPressed: () =>
                    _ClickElevatedButton(icon: "favorite", color: Colors.pink),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 24.0,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 角丸を適用
                  ),
                ),
                onPressed: () => _ClickElevatedButton(
                    icon: "audiotrack", color: Colors.green),
                child: const Icon(
                  Icons.audiotrack,
                  color: Colors.green,
                  size: 30.0,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 角丸を適用
                  ),
                ),
                onPressed: () => _ClickElevatedButton(
                    icon: "beach_access", color: Colors.blue),
                child: const Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                ),
              ),
            ],
          ),
          Text(
            '$_text',
            style: TextStyle(fontSize: 20, color: _color),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _ClickFloatingActionButton,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("プログラミング言語ロゴ",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 89, 108, 214))),
            TextButton(
              onPressed: () => _ClickTextButton2(
                  "data:image/png;base64,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"),
              child: const Text("Dart"),
            ),
            TextButton(
              onPressed: () => _ClickTextButton2(
                  "data:image/png;base64,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"),
              child: const Text("Rust"),
            ),
            TextButton(
              onPressed: () => _ClickTextButton2(
                  "data:image/png;base64,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"),
              child: const Text("Go"),
            ),
            TextButton(
              onPressed: () => _ClickTextButton2(
                  "data:image/png;base64,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"),
              child: const Text("Clojure"),
            ),
            _logoUrl.isNotEmpty
                ? Image.memory(_decodeBase64(_logoUrl))
                : Container(),
          ],
        ),
      ),
    );
  }
}

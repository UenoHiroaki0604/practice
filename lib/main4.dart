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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _text = TextEditingController();
  String _ward = "";

  void _indexWiki() {
    setState(() {
      _ward = _text.text;
      final url = Uri.parse('https://ja.wikipedia.org/wiki/$_ward');
      launchUrl(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '検索',
                ),
              ),
            ),
            IconButton(
              onPressed: _indexWiki,
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}

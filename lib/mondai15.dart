import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // データを格納する変数
  List<String> name = ["青森", "岩手", "秋田", "宮城", "山形", "福島"];
  List<double> population = [124.9, 122.9, 96.6, 230.6, 108, 184.8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                // データの取得
                for (int i = 0; i < name.length; i++) {
                  await FirebaseFirestore.instance
                      .collection('ex15Collection')
                      .doc(name[i])
                      .set({'name': name[i], "population": population[i]},
                          SetOptions(merge: true));
                }
                // データを整形して表示用にセット

                // 状態を更新
              },
              child: const Text(
                '東北六県基本情報追加',
                style: TextStyle(fontSize: 50),
              ),
            ),
            // 取得したデータを表示
          ],
        ),
      ),
    );
  }
}

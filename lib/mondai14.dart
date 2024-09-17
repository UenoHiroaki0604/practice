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
  String text = "";

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
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection('ex14Collection')
                    .get();

                // データを整形して表示用にセット
                String fetchedText = "";
                querySnapshot.docs.forEach((doc) {
                  fetchedText +=
                      "大名：${doc.get("name")} 年齢：${doc.get("age")} \n"; // 各ドキュメントの "name" フィールドを取得
                });

                // 状態を更新
                setState(() {
                  text = fetchedText;
                });
              },
              child: const Text(
                '大名一覧取得',
                style: TextStyle(fontSize: 50),
              ),
            ),
            // 取得したデータを表示
            if (text.isNotEmpty)
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}

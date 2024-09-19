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
  List<String> name = ["青森", "茨木", "静岡", "石川", "愛媛", "佐賀"];
  List<String> prefectural = ["青森", "水戸", "静岡", "金沢", "松山", "佐賀"];
  List<String> region = ["東北", "関東", "東海", "北陸", "四国", "九州"];
  List<double> population = [124.9, 122.9, 96.6, 230.6, 108, 184.8];
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
                for (int i = 0; i < name.length; i++) {
                  await FirebaseFirestore.instance
                      .collection('ex16Collection')
                      .doc(name[i])
                      .set({
                    '県名': name[i],
                    "人口": population[i],
                    "県庁所在地": prefectural[i],
                    "地方": region[i]
                  }, SetOptions(merge: true));
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
            TextButton(
              onPressed: () async {
                // データの取得
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection('ex16Collection')
                    .get();

                // データを整形して表示用にセット
                String fetchedText = "";
                querySnapshot.docs.forEach((doc) {
                  fetchedText +=
                      "県名：${doc.get("県名")} 人口：${doc.get("人口")} 県庁所在地：${doc.get("県庁所在地")} 地方：${doc.get("地方")} \n"; // 各ドキュメントの "name" フィールドを取得
                });

                // 状態を更新
                setState(() {
                  text = fetchedText;
                });
              },
              child: const Text(
                '県基本情報一覧取得',
                style: TextStyle(fontSize: 50),
              ),
            ),
            // 取得したデータを表示
            if (text.isNotEmpty)
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            // 取得したデータを表示
          ],
        ),
      ),
    );
  }
}

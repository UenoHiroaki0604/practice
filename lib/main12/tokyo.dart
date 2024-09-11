import 'package:flutter/material.dart';

class Tokyo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("東京駅"),
        ),
        body: Center(
            child: Column(
          children: [
            Image.network(
              'https://www.jreast.co.jp/station_photo/station/tokyo/01.jpg',
              width: 1000, // 画像の幅を指定
              height: 300, // 画像の高さを指定
            ),
            TextButton(
                onPressed: () => {
                      // Navigatorを使って新しいページ（TestPage2）に遷移
                      Navigator.of(context).pushNamed("/utsunomiya")
                    },
                child: const Text("次の駅☞", style: TextStyle(fontSize: 50)))
          ],
        )));
  }
}

import 'package:flutter/material.dart';

class Sendai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("仙台駅"),
        ),
        body: Center(
          child: Image.network(
            'https://www.jreast.co.jp/station_photo/station/sendai/01.jpg',
            width: 1000, // 画像の幅を指定
            height: 300, // 画像の高さを指定
          ),
        ));
  }
}

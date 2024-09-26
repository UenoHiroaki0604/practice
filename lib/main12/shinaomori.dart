import 'package:flutter/material.dart';

class Shinaomori extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("新青森駅"),
        ),
        body: Center(
          child: Image.network(
            'https://www.jreast.co.jp/station_photo/station/shin-aomori/01.jpg',
            width: 1000, // 画像の幅を指定
            height: 300, // 画像の高さを指定
          ),
        ));
  }
}

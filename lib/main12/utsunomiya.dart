import 'package:flutter/material.dart';

class Utsunomiya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("宇都宮駅"),
        ),
        body: Center(
          child: Image.network(
            'https://www.jreast.co.jp/station_photo/station/utsunomiya/01.jpg',
            width: 1000, // 画像の幅を指定
            height: 300, // 画像の高さを指定
          ),
        ));
  }
}

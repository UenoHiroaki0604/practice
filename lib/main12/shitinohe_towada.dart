import 'package:flutter/material.dart';

class ShitinoheTowada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("七戸十和田駅"),
        ),
        body: Center(
            child: Column(
          children: [
            Image.network(
              'https://www.jreast.co.jp/station_photo/station/shichinohe-towada/01.jpg',
              width: 1000, // 画像の幅を指定
              height: 300, // 画像の高さを指定
            ),
            TextButton(
                onPressed: () =>
                    {Navigator.of(context).pushNamed("/shinaomori")},
                child: const Text("次の駅☞", style: TextStyle(fontSize: 50))),
            TextButton(
                onPressed: () => {Navigator.of(context).pop()},
                child: const Text("前の駅☚", style: TextStyle(fontSize: 50)))
          ],
        )));
  }
}

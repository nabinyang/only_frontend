import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('ID : 이조은'),
          Text('안전 등급 확인 : N건'),
          for (int i = 0; i < 4; i++)
            Card(child: (Column(children: [Icon(Icons.image), Text('$i')]))),
          Text('서비스 이용 후기 남기기'),
        ],
      )),
    );
  }
}

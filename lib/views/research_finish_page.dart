import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only/views/main_page.dart';

class ResearchFinishPage extends StatelessWidget {
  const ResearchFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('우리집 안전 등급')),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '우리 집 안전 등급 산출에 응해주셔서 감사합니다. 지금은 등급 산출이 진행되는 중입니다. 최대 24시간 이내로 등급이 산출됩니다.등급 결과가 나오면 알림을 보내드리겠습니다.',
                textAlign: TextAlign.justify,
              ),
              ElevatedButton(
                  onPressed: () => Get.to(() => MainPage()),
                  child: Text('메인 페이지로 이동'))
            ],
          ),
        ));
  }
}

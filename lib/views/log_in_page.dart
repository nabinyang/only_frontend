import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only/views/sign_up_page.dart';

import 'main_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Placeholder(
            fallbackHeight: 50,
          ),
          Form(
            key: this.formKey,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '아이디'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '비밀번호'),
              ),
            ]),
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => MainPage()), child: Text('로그인')),
          Text('아직 계정이 없으신가요?'),
          ElevatedButton(
              onPressed: () => Get.to(() => SignUp()), child: Text('회원가입')),
          Text('회원가입 전에 둘러보실래요?'),
          ElevatedButton(
              onPressed: () => Get.to(() => MainPage()), child: Text('둘러보기')),
        ],
      )),
    );
  }
}

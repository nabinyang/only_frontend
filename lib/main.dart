import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only/views/log_in_page.dart';
import 'package:only/views/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool isLogIn = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: isLogIn ? MainPage() : LogInPage(),
      theme: ThemeData(primarySwatch: primaryBlack),
      debugShowCheckedModeBanner: false,
    );
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

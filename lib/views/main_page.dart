import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';

import 'my_page.dart';
import 'notification_page.dart';
import 'research_first_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.abc),
        leading: TextButton(
          onPressed: () => Get.to(() => NotificationPage()),
          child: Text('알림', style: TextStyle(color: Colors.white)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.to(() => MyPage()),
            child: Text('MY Page', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100,
            child: Swiper(
              autoplay: true,
              duration: 1500,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  "https://via.placeholder.com/350x150",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => ResearchFirstPage()),
              child: Text('안전 등급 산출하기')),
          ElevatedButton(onPressed: () {}, child: Text('의견 보내기'))
        ],
      )),
    );
  }
}

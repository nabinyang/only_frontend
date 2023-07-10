import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:only/views/research_finish_page.dart';

class ResearchSecondPage extends StatefulWidget {
  ResearchSecondPage({super.key});

  @override
  State<ResearchSecondPage> createState() => _ResearchSecondPageState();
}

class _ResearchSecondPageState extends State<ResearchSecondPage> {
  final formKey = GlobalKey<FormState>();
  SliderController _SliderController = SliderController(0.0);
  List requestList = [];

  double safety = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int count = 0;
    for (var item in Get.arguments) {
      if (count == 4 || count == 5) {
        requestList.add(int.parse(item));
      }
      requestList.add(item);
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('우리집 안전 등급'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  '이 설문은 추후 안전 등급 산출의 신뢰도 향상을 위한 데이터 수집 목적으로 이루어집니다. 현재 등급산출에는 영향을 미치지 않으니 솔직하게 답변 바랍니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  '우리 집 안전 체감도 조사',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('현재 본인 집의 안전도',
                            style: TextStyle(
                              fontSize: 17,
                            )),
                        Slider(
                          value: _SliderController.sliderValue,
                          min: 0.0,
                          max: 10.0,
                          divisions: 10,
                          label: '${_SliderController.sliderValue.round()}',
                          onChanged: (double newValue) {
                            setState(
                              () {
                                _SliderController.sliderValue = newValue;
                                safety = newValue;
                              },
                            );
                          },
                        ),
                      ]),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('안전하지 않다'), Text('안전하다')],
                ),
                renderButton(),
              ]),
        ),
      ),
    );
  }

  renderButton() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          // validation 이 성공하면 true 가 리턴돼요!
          this.formKey.currentState!.save();

          requestList.add(safety);

          
          Get.to(() => ResearchFinishPage(), arguments: []);
        }
      },
      child: Text(
        '제출하기',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

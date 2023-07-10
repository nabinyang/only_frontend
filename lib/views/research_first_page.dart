import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:kpostal/kpostal.dart';

import 'research_second_page.dart';

class ResearchFirstPage extends StatefulWidget {
  ResearchFirstPage({super.key});

  @override
  State<ResearchFirstPage> createState() => _ResearchFirstPageState();
}

class _ResearchFirstPageState extends State<ResearchFirstPage> {
  final formKey = GlobalKey<FormState>();
  SliderController SliderController1 = SliderController(0.0);
  SliderController SliderController2 = SliderController(0.0);

  String address = '';
  double roomNumber = 0;
  double toiletNumber = 0;
  String floor = '';
  String fullFloor = '';
  int dwellingType = 0;
  bool isDwellingTypeSelected = false;
  List facilityList = [false, false, false, false];

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
                '안전 등급 산출을 위해서는 데이터 입력이 필요합니다. 정확한 등급 산출을 위해 집에 대한 올바른 정보를 기입해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                '우리 집 정보 기입',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  '주소',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 16.0),
                address == ''
                    ? TextButton(
                        onPressed: () async {
                          Kpostal result = await Navigator.push(context,
                              MaterialPageRoute(builder: (_) => KpostalView()));
                          setState(() {
                            address = result.address;
                          });
                        },
                        child: Text('주소 검색'),
                      )
                    : Text(
                        address,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                SizedBox(height: 16.0),
                renderButtonField(
                  label: '주거 형태',
                  isRadio: true,
                  buttonList: ['원룸/오피스텔', '아파트', '주택', '기타'],
                ),
                renderSlider(
                    label: '방 개수', max: 7, sliderController: SliderController1),
                renderSlider(
                    label: '화장실 개수',
                    max: 3,
                    sliderController: SliderController2),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        renderTextFormField(
                            label: '해당층',
                            onSaved: (val) {
                              setState(() {
                                floor = val;
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수사항입니다.';
                              }
                              // if (RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$')
                              //     .hasMatch(val)) {
                              //   return '잘못된 형식입니다.';
                              // }
                              return null;
                            }),
                        renderTextFormField(
                            label: '총층',
                            onSaved: (val) {
                              setState(() {
                                fullFloor = val;
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수사항입니다.';
                              }
                              return null;
                            }),
                      ],
                    )),
                renderButtonField(
                  label: '방범시설 유무',
                  isRadio: false,
                  buttonList: ['도어락', '공동현관키패드', 'CCTV', '택배함'],
                ),
              ]),
              renderButton(),
              renderValues(),
            ]),
      )),
    );
  }

  renderTextFormField({
    String? label,
    FormFieldSetter? onSaved,
    FormFieldValidator? validator,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onSaved: onSaved,
          validator: validator,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  renderButtonField({
    String? label,
    List? buttonList,
    bool? isRadio,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label!,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GroupButton(
            options: GroupButtonOptions(
              selectedShadow: const [],
              unselectedShadow: const [],
              borderRadius: BorderRadius.circular(4),
              spacing: 10,
              runSpacing: 10,
              groupingType: GroupingType.wrap,
              direction: Axis.horizontal,
              selectedTextStyle: TextStyle(fontSize: 12),
              unselectedTextStyle: TextStyle(fontSize: 12, color: Colors.black),
              buttonHeight: 40,
              buttonWidth: 70,
              mainGroupAlignment: MainGroupAlignment.start,
              crossGroupAlignment: CrossGroupAlignment.start,
              groupRunAlignment: GroupRunAlignment.start,
              textAlign: TextAlign.center,
              textPadding: EdgeInsets.zero,
              alignment: Alignment.center,
              elevation: 3,
            ),
            isRadio: isRadio!,
            buttons: buttonList!,
            onSelected: (dynamic, index, isSelected) {
              print('$index button $isSelected');
              if (label == '주거 형태') {
                if (isSelected) {
                  dwellingType = index;
                }
              } else {
                if (isSelected) {
                  facilityList[index] = true;
                } else {
                  facilityList[index] = false;
                }
              }
            }),
      ),
      SizedBox(height: 16.0),
    ]);
  }

  renderButton() {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          // validation 이 성공하면 true 가 리턴돼요!

          this.formKey.currentState!.save();
          Get.to(() => ResearchSecondPage(), arguments: [
            address,
            dwellingType,
            roomNumber,
            toiletNumber,
            floor,
            fullFloor,
            facilityList
          ]);
        }
      },
      child: Text(
        '다음 단계',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  renderSlider({
    String? label,
    int? max,
    SliderController? sliderController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!,
            style: TextStyle(
              fontSize: 17,
            )),
        Slider(
          value: sliderController!.sliderValue,
          min: 0.0,
          max: max!.toDouble(),
          divisions: max,
          label: '${sliderController.sliderValue.round()}',
          onChanged: (double newValue) {
            setState(
              () {
                sliderController.sliderValue = newValue;
                if (label == '방 개수') {
                  roomNumber = newValue;
                } else {
                  toiletNumber = newValue;
                }
              },
            );
          },
        ),
      ],
    );
  }

  renderValues() {
    return Column(
      children: [
        Text('주소: $address'),
        Text('주거 형태: $dwellingType'),
        Text(
          '방 수: $roomNumber',
        ),
        Text(
          '화장실 수: $toiletNumber',
        ),
        Text(
          '현재 층: $floor',
        ),
        Text(
          '총 층: $fullFloor',
        ),
        Text(
          '방범시설 유무: $facilityList',
        ),
      ],
    );
  }
}

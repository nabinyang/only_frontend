import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:only/views/log_in_page.dart';
import 'package:only/views/main_page.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isAgree = false;

  String name = '';
  int birth = 0;
  String gender = 'M';
  String phone = '';
  String id = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                renderTextFormField(
                    label: '이름',
                    onSaved: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                    validator: (val) {
                      if (val.length < 1) {
                        return '필수사항입니다.';
                      }
                      return null;
                    }),
                renderTextFormField(
                            label: '생년월일',
                            onSaved: (val) {
                              setState(() {
                                birth = int.parse(val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수사항입니다.';
                              }
                              return null;
                            }),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '성별',
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
                          unselectedTextStyle:
                              TextStyle(fontSize: 12, color: Colors.black),
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
                        isRadio: true,
                        buttons: ['남자', '여자'],
                        onSelected: (dynamic, index, isSelected) {
                          print('$index button $isSelected');
                          setState(() {
                            if (index == 0) {
                              gender = 'M';
                            } else {
                              gender = 'F';
                            }
                          });
                        }),
                  ),
                  SizedBox(height: 16.0),
                ]),
                renderTextFormField(
                            label: '휴대폰 번호',
                            onSaved: (val) {
                              setState(() {
                                phone = val;
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수사항입니다.';
                              }
                              return null;
                            }),
                renderTextFormField(
                            label: '아이디',
                            onSaved: (val) {
                              setState(() {
                                id = val;
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '필수사항입니다.';
                              }
                              return null;
                            }),
                ElevatedButton(onPressed: ()=> checkUserId(), child: Text('중복확인')),
                TextFormField(
                    decoration: const InputDecoration(labelText: '비밀번호')),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: false,
                  onChanged: (value) {
                    isAgree = value!;
                  }),
              const Text('이용 약관 동의'),
            ],
          ),
          ElevatedButton(
              onPressed: () => Get.to(() => MainPage()),
              child: const Text('회원가입')),
          const Text('이미 계정이 있으신가요?'),
          TextButton(
              onPressed: () => Get.to(() => LogInPage()),
              child: const Text('회원로그인')),
          const Text('회원가입 전에 둘러보실래요?'),
          TextButton(
              onPressed: () => Get.to(() => MainPage()),
              child: const Text('둘러보기')),
        ],
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

  checkUserId() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });
      if (res.statusCode == 200) {
        var rep = jsonDecode(res.body);

        if (rep['existEmail'] == true) {
          Get.snackbar(
            '메시지',
            '에러메시지',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text('이미 있는 이메일입니다.'),
          );
        } else {
          await saveInfo();
          userLogin();
        }
      }
    } catch (e) {
      Get.snackbar(
        '메시지',
        '에러메시지',
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(e.toString()),
      );
    }
  }
}

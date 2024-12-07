// 이용약관 화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';

import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({super.key});

  @override
  _TermsOfServicePage createState() => _TermsOfServicePage();
}

class _TermsOfServicePage extends State<TermsOfServicePage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
            }
          },
          child:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '이용 약관',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 60.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ).tr(),
        backgroundColor: Color.fromARGB(204, 34, 83, 111),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '제1조 (목적)'.tr() + '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n' +
                          '스마트환승철(이하 “회사”라 합니다)는 회사가 제공하는 지하철 서비스에 대한 약관을 마련하였습니다.'
                              .tr() +
                          ' ' +
                          '본 약관은 회사와 회원의 권리와 의무, 책임관계, 기타 필요한 사항을 규정하고 있습니다.'
                              .tr() +
                          '\n\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '제2조 (정의)'.tr() + '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n' +
                          '본 약관에서 사용하는 용어의 뜻은 다음과 같습니다.'.tr() +
                          '\n' +
                          '스마트환승철: 회원이 휴대전화 등을 통하여 지하철 서비스를 이용할 수 있도록 회사가 제공하는 일체의 어플리케이션을 말합니다.'
                              .tr() +
                          '\n' +
                          '스마트환승철 서비스: 스마트환승철을 통해서 제공하는 일체의 서비스를 의미합니다.'.tr() +
                          '\n' +
                          '회원: 본 약관에 동의하고, 회사가 제공하는 스마트환승철 서비스 전체를 이용하는 고객을 말합니다.'
                              .tr() +
                          '(' +
                          '회원이 아니어도 정보제공 서비스는 이용할 수 있습니다.'.tr() +
                          ')' +
                          '\n\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '제3조 (약관의 효력 및 변경)'.tr() + '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\n' +
                          '본 약관의 내용은 스마트환승철 화면에 게시하거나 기타의 방법으로 회원에게 공시하고, 본 약관에 동의한 회원에게 그 효력이 있습니다.'
                              .tr() +
                          '\n' +
                          '회사는 필요한 경우 관련법령을 위배하지 않는 범위 내에서 본 약관을 변경할 수 있습니다.'
                              .tr() +
                          '회사가 본 약관을 변경할 경우에는 적용일자, 변경사유를 명시하여 적용일자 7일 전부터 공지하거나, 회원에게 개별 통지합니다.'
                              .tr() +
                          '회원에게 불리한 약관의 변경인 경우에는 그 적용일자 30일 전부터 공지하거나, 회원에게 개별 통지합니다.'
                              .tr() +
                          '\n',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white70
                            : Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      // 하단바
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
      ),
    );
  }
}

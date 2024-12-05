// 환경설정 화면
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/killingTime.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';

import 'RegionSettings.dart';
import 'DisplayMode.dart'; 
import 'LocalServiceTerms.dart'; 
import 'PrivacyPolicy.dart'; 
import 'TermsOfService.dart';

void main() {
  runApp(const MaterialApp(
    home: settings(),
  ));
}

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<settings> {
  final List<Map<String, String>> settingsOptions = [
    {'title': '지역 설정', 'page': 'RegionSettings'},
    {'title': '화면 모드', 'page': 'DisplayMode'},
    {'title': '위치기반 서비스 이용 약관', 'page': 'LocalServiceTerms'},
    {'title': '개인정보 처리 방침', 'page': 'PrivacyPolicy'},
    {'title': '이용약관', 'page': 'TermsOfService'},
  ];

 // 리스트 항목 클릭 시 이동할 함수
  void onItemTap(BuildContext context, String pageName) {
    // 선택된 항목에 맞는 페이지로 이동
    if (pageName == 'RegionSettings') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegionSettingsPage()),
      );
    } else if (pageName == 'DisplayMode') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayModePage()),
      );
    } else if (pageName == 'LocalServiceTerms') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocalServiceTermsPage()),
      );
    } else if (pageName == 'PrivacyPolicy') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
      );
    } else if (pageName == 'TermsOfService') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsOfServicePage()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
            }
          },
          child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '환경설정',
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), // 전체 패딩
              itemCount: settingsOptions.length,
              itemBuilder: (context, index) {
                final option = settingsOptions[index];
                return Column(
                  children: [
                    // 항목
                    ListTile(
                      onTap: () => onItemTap(context, option['page']!),
                      title: Text(
                        option['title']!,
                        style: const TextStyle(
                          color: Color(0xFF22536F),
                          fontSize: 16,
                        ),
                      ).tr(),
                    ),
                    // 구분선
                    const Divider(
                      color: Color(0xFFD5D5D5),
                      height: 1,
                      thickness: 1,
                    ),
                    if (index < settingsOptions.length - 1)
                      const SizedBox(height: 30), 
                  ],
                );
              },
            ),
          ),
        ],
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

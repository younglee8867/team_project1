// 환경설정 화면
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/killingTime.dart';
import 'package:easy_localization/easy_localization.dart';

import 'RegionSettings.dart';
import 'DisplayMode.dart'; 
import 'LocalServiceTerms.dart'; 
import 'PrivacyPolicy.dart'; 
import 'TermsOfService.dart';

void main() {
  runApp(const MaterialApp(
    home: Settings(),
  ));
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  final List<Map<String, String>> settingsOptions = [
    {'title': '지역 설정', 'page': 'RegionSettings'},
    {'title': '화면 모드', 'page': 'DisplayMode'},
    {'title': '위치기반 서비스 이용 약관', 'page': 'LocalServiceTerms'},
    {'title': '개인정보 처리 방침', 'page': 'PrivacyPolicy'},
    {'title': '이용약관', 'page': 'TermsOfService'},
  ];

  // 리스트 항목 클릭 시 이동할 함수
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
            }
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '환경설정',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
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
                      ),
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
      )
  );
  }
}

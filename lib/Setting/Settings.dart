import 'package:flutter/material.dart';
import 'RegionSettings.dart'; // RegionSettings 페이지 임포트
import 'DisplayMode.dart'; // DisplayMode 페이지 임포트
import 'LocalServiceTerms.dart'; // LocalServiceTerms 페이지 임포트
import 'PrivacyPolicy.dart'; // PrivacyPolicy 페이지 임포트
import 'TermsOfService.dart'; // TermsOfService 페이지 임포트

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Settings(),
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final List<Map<String, String>> settingsOptions = [
    {'title': '       지역 설정', 'page': 'RegionSettings'},
    {'title': '       화면 모드', 'page': 'DisplayMode'},
    {'title': '       위치기반 서비스 이용 약관', 'page': 'LocalServiceTerms'},
    {'title': '       개인정보 처리 방침', 'page': 'PrivacyPolicy'},
    {'title': '       이용약관', 'page': 'TermsOfService'},
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
    return Container(
      width: 412,
      height: 917,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // 헤더 부분 (로고 및 텍스트)
          Positioned(
            left: 13,
            top: 65,
            child: Container(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF22536F), // 아이콘 색상
                    ),
                    onPressed: () {
                      // 뒤로가기 동작 추가 가능
                    },
                  ),
                  Positioned(
                    left: 42,
                    top: 10,
                    child: Text(
                      '환경설정',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 23,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 버전 텍스트
          Positioned(
            left: 1,
            top: 820,
            child: SizedBox(
              width: 81,
              child: Text(
                '앱 버전 1.1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCDCDCD),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0.17,
                  letterSpacing: 0.50,
                ),
              ),
            ),
          ),
          // 설정 항목 리스트
          Positioned(
            left: 11,
            top: 110,
            child: Container(
              width: 356,
              height: 381,
              child: Column(
                children: settingsOptions.map((option) {
                  return GestureDetector(
                    onTap: () => onItemTap(context, option['page']!), // 클릭 시 동작
                    child: Container(
                      width: 356,
                      height: 61,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 23,
                            child: SizedBox(
                              width: 220,
                              height: 200,
                              child: Text(
                                option['title']!,
                                textAlign: TextAlign.left, // 텍스트 왼쪽 정렬
                                style: TextStyle(
                                  color: Color(0xFF22536F),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 31,
                            top: 53,
                            child: Container(
                              width: 325,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(0xFFD5D5D5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // 하단 텍스트 - 중앙 정렬
          Positioned(
            left: 141,
            top: 810,
            child: SizedBox(
              width: 130, // 중앙 정렬을 위한 너비 조정
              child: Text(
                '스마트 환승철',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF387394),
                  fontSize: 14,
                  fontFamily: 'Kode Mono',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

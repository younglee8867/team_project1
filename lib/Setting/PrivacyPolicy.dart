import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';
void main() {
  runApp(
    MaterialApp(
      home: PrivacyPolicyPage(),
    ),
  );
}


class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPage createState() => _PrivacyPolicyPage();
}

class _PrivacyPolicyPage extends State<PrivacyPolicyPage> {
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
          '개인정보 처리 방침',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Text(
                 '\n<스마트 환승철>은(는) 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. \n\n이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.\n\n',
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
              SizedBox(height: 20),
               Text(
                  '주요 개인정보 처리 표시', // 텍스트 내용
                  style: TextStyle(
                            fontSize: 23, // 텍스트 크기
                            color: Color(0xFF22536F), // 텍스트 색상
                            fontWeight: FontWeight.bold,
                ),
             ).tr(),
             SizedBox(height: 50),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                  crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
                  children: [
                    // 첫 번째 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로 균등 정렬
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet1.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '일반 개인정보의 수집',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet2.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '민감정보 수집',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50), // Row 간 간격
                    // 두 번째 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet3.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '개인정보의 처리 목적',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet4.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '개인정보의 보유 기간',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    // 세 번째 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet5.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '개인정보의 제공',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/settings/privacySet6.png',
                                fit: BoxFit.cover,
                                width: 77,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '개인정보의 파기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFA0A0A0),
                                  fontWeight: FontWeight.normal,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )


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

/*                    TextSpan(
                      text: '주요 개인정보 처리 표시\n\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '일반 개인정보의 수집\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보 처리 목적\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 제공\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 파기\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 보유 기간\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '민감정보 수집\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify, */
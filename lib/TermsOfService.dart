import 'package:flutter/material.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TermsOfServicePage(),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 787,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // Title Text
              Positioned(
                left: 20,
                top: 10,
                child: SizedBox(
                  width: 150,
                  height: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF22536F), // 아이콘 색상
                        ),
                        onPressed: () {
                          // 여기에 클릭 시 수행할 동작을 추가하세요.
                          // 예시: Navigator.pop(context); // 뒤로가기
                          Navigator.pop(context); // 뒤로가기
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        '이용약관',
                        style: TextStyle(
                          color: Color(0xFF22536F),
                          fontSize: 24,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Footer: App Version and App Name
              const Positioned(
                left: 1,
                top: 760,
                child: SizedBox(
                  width: 81,
                  child: Text(
                    '앱 버전 1.1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFCDCDCD),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.50,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 141,
                top: 760,
                child: SizedBox(
                  width: 129.86,
                  height: 29.57,
                  child: Text(
                    '스마트 환승철',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF387394),
                      fontSize: 12,
                      fontFamily: 'Kode Mono',
                      height: 0,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ),

              // Terms Text Section
              const Positioned(
                left: 33,
                top: 100,
                child: SizedBox(
                  width: 345,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '제1조 (목적)\n\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '''
스마트환승철(이하 “회사”라 합니다)는 회사가 제공하는 지하철 서비스에 대한 약관(이하 ‘본 약관’이라 합니다)을 마련하였습니다. 본 약관은 회사와 회원의 권리와 의무, 책임관계, 기타 필요한 사항을 규정하고 있습니다.
\n''',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 11,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '제2조 (정의)\n\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '''
본 약관에서 사용하는 용어의 뜻은 다음과 같습니다.
스마트환승철: 회원이 휴대전화 등을 통하여 지하철 서비스를 이용할 수 있도록 회사가 제공하는 일체의 어플리케이션을 말합니다.
스마트환승철 서비스: 스마트환승철을 통해서 제공하는 일체의 서비스를 의미합니다.
회원: 본 약관에 동의하고, 회사가 제공하는 스마트환승철 서비스 전체를 이용하는 고객을 말합니다(회원이 아니어도 정보제공 서비스는 이용할 수 있습니다).
\n''',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 11,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '제3조 (약관의 효력 및 변경)\n\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '''
본 약관의 내용은 카카오지하철 화면에 게시하거나 기타의 방법으로 회원에게 공시하고, 본 약관에 동의한 회원에게 그 효력이 있습니다.
회사는 필요한 경우 관련법령을 위배하지 않는 범위 내에서 본 약관을 변경할 수 있습니다. 회사가 본 약관을 변경할 경우에는 적용일자, 변경사유를 명시하여 적용일자 7일 전부터 공지하거나, 회원에게 개별 통지합니다. 회원에게 불리한 약관의 변경인 경우에는 그 적용일자 30일 전부터 공지하거나, 회원에게 개별 통지합니다.
회사가 제2항에 따라 회원에게 공지 또는 통지를 하면서 ‘약관 변경 적용일까지 거부의사를 표시하지 않을 경우 약관의 변경에 동의한 것으로 본다’는 내용을 명확하게 고지하였음에도 회원이 명시적으로 약관 변경에 대한 거부의사를 표시하지 않은 경우 회원은 변경된 약관 내용에 동의한 것으로 봅니다.
회원이 변경된 약관 사항에 동의하지 않으면 회사는 개정 약관의 내용을 적용할 수 없고, 회원은 카카오지하철 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 다만, 회사는 개정약관에 부동의한 회원에게 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 해당 회원과의 이용계약을 해지할 수 있습니다.
\n''',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 11,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

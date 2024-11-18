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
          child: LocalServiceTermsPage(),
        ),
      ),
    );
  }
}

class LocalServiceTermsPage extends StatelessWidget {
  const LocalServiceTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 785,
          decoration: BoxDecoration(
            color: Colors.white, // 배경색을 하얀색으로 설정

            borderRadius: BorderRadius.circular(10), // 둥근 모서리 (옵션)
          ),
          child: Stack(
            children: [
              Positioned(
                left: 22,
                top: 40,
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
                    const SizedBox(width: 10),
                    const Text(
                      '위치기반 서비스 이용 약관',
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 23,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 20,
                top: 740,
                child: Text(
                  '앱 버전 1.1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFCDCDCD),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Positioned(
                left: 141,
                top: 740,
                child: Text(
                  '스마트 환승철',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF387394),
                    fontSize: 14,
                    fontFamily: 'Kode Mono',
                    letterSpacing: 5,
                  ),
                ),
              ),
              const Positioned(
                left: 33,
                top: 130,
                child: SizedBox(
                  width: 330,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '제1조 (목적)\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text:
                              '\n본 약관은 회원(본 약관에 동의한 자를 말합니다. 이하 “회원”이라고 합니다)이 스마트 환승철(이하 “회사”라고 합니다)이 제공하는 위치정보서비스 및 위치기반서비스(이하 “서비스”라고 합니다)를 이용함에 있어 회사와 회원의 권리•의무 및 책임사항을 규정함을 목적으로 합니다.\n\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '제2조 (약관의 효력 및 변경)\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text:
                              '\n본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.\n'
                              '회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 서비스 초기 화면에 게시하거나 기타의 방법으로 공지합니다.\n'
                              '회사는 필요하다고 인정되면 본 약관을 변경할 수 있으며, 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 현행약관과 함께 그 적용일자 7일 전부터 적용일 이후 상당한 기간 동안 공지합니다. 다만, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다.\n'
                              '회사가 전항에 따라 회원에게 공지하거나 통지하면서 공지 또는 통지ㆍ고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 불구하고 거부의 의사표시가 없는 경우에는 변경된 약관에 승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.\n\n',
                          style: TextStyle(
                            color: Color(0xFFA0A0A0),
                            fontSize: 12,
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

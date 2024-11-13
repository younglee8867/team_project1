import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Five_four(),
            ],
          ),
        ),
      ),
    );
  }
}

class Five_four extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      width: 412,
      height: 787,
      child: Stack(
        children: [
          Positioned(
            left: 13,
            top: 12,
            child: Container(
              width: 231,
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Color(0xFF22536F), // 아이콘 색상
                  ),
                  SizedBox(width: 10), // 아이콘 대신 공간 확보
                  SizedBox(width: 5), // 텍스트와의 간격
                  Text(
                    '개인정보 처리 방침',
                    style: TextStyle(
                      color: Color(0xFF22536F),
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 33,
            top: 270,
            child: Text(
              '주요 개인정보 처리 표시',
              style: TextStyle(
                color: Color(0xFF22536F),
                fontSize: 17,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Positioned(
            left: 1,
            top: 750,
            child: SizedBox(
              width: 81,
              child: Text(
                '앱 버전 1.1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCDCDCD),
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            left: 141,
            top: 750,
            child: SizedBox(
              width: 129.86,
              height: 29.57,
              child: Text(
                '스마트 환승철',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF387394),
                  fontSize: 10,
                  fontFamily: 'Kode Mono',
                  letterSpacing: 5,
                ),
              ),
            ),
          ),
          Positioned(
            left: 33,
            top: 70,
            child: SizedBox(
              width: 340,
              child: Text(
                '''<스마트 환승철>은(는) 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」및 
                관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다.\n이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 
                절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.''',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 13,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          Positioned(
            left: 59,
            top: 380,
            child: Container(
              width: 295,
              height: 298,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '일반 개인정보의 수집',
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6,
                    top: 140,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '개인정보 처리 목적',
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 280,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '개인정보의 제공',
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 186,
                    top: 280,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '개인정보의 파기',
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 172,
                    top: 140,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '개인정보의 보유 기간',
                            style: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: 193,
                    top: 0,
                    child: Text(
                      '민감정보 수집',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

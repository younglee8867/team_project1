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
          child: FiveTwo(),
        ),
      ),
    );
  }
}

class FiveTwo extends StatefulWidget {
  @override
  _FiveTwoState createState() => _FiveTwoState();
}

class _FiveTwoState extends State<FiveTwo> {
  // 상태 변수
  bool isLightModeSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 412,
          height: 785,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 1,
                top: 765,
                child: SizedBox(
                  width: 81,
                  child: Text(
                    '앱 버전 1.1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFCDCDCD),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      height: 0.17,
                      letterSpacing: 0.50,
                    ),
                  ),
                ),
              ),
              Positioned(
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
                      fontSize: 11,
                      fontFamily: 'Kode Mono',
                      height: 1.0,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Color(0xFF22536F), // 아이콘 색상
                    ),
                    SizedBox(width: 10), // 아이콘과 텍스트 사이에 간격 추가
                    Text(
                      '화면 모드',
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 147,
                top: 330,
                child: SizedBox(
                  width: 118,
                  height: 23,
                  child: Text(
                    '라이트 모드',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF21536F),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      height: 1.5,
                      letterSpacing: 0.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 193,
                top: 360, // 라이트 모드 버튼 위치 조정
                child: Radio<int>(
                  value: 1,
                  groupValue: isLightModeSelected ? 1 : 0,
                  onChanged: (value) {
                    setState(() {
                      isLightModeSelected = value == 1;
                    });
                  },
                  activeColor: Color(0xFF21536F),
                ),
              ),
              Positioned(
                left: 147,
                top: 660,
                child: SizedBox(
                  width: 118,
                  height: 23,
                  child: Text(
                    '다크 모드',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF21536F),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      height: 1.5,
                      letterSpacing: 0.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 193,
                top: 690, // 다크 모드 버튼 위치 조정
                child: Radio<int>(
                  value: 0,
                  groupValue: isLightModeSelected ? 1 : 0,
                  onChanged: (value) {
                    setState(() {
                      isLightModeSelected = value == 1;
                    });
                  },
                  activeColor: Color(0xFF21536F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);
  final ValueNotifier<double> _widthFactor = ValueNotifier<double>(1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ValueListenableBuilder<bool>(
            valueListenable: _dark,
            builder: (context, color, child) {
              return ValueListenableBuilder<double>(
                valueListenable: _widthFactor,
                builder: (context, factor, child) {
                  return Scaffold(
                      backgroundColor:
                          _dark.value ? Colors.black : Colors.white,
                      appBar: AppBar(
                        actions: [
                          Switch(
                            value: _dark.value,
                            onChanged: (value) {
                              _dark.value = value;
                            },
                          ),
                          DropdownButton<double>(
                            value: _widthFactor.value,
                            onChanged: (value) {
                              _widthFactor.value = value!;
                            },
                            items: [
                              DropdownMenuItem(
                                  value: 0.5, child: Text('Size: 50%')),
                              DropdownMenuItem(
                                  value: 0.75, child: Text('Size: 75%')),
                              DropdownMenuItem(
                                  value: 1.0, child: Text('Size: 100%')),
                            ],
                          ),
                        ],
                      ),
                      body: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              _widthFactor.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StationInfoContainer(),
                            ],
                          ),
                        ),
                      ));
                },
              );
            }));
  }
}

class StationInfoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 800,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          buildTitleSection(),
          buildStationDivider(top: 210.53),
          buildStationDivider(top: 303.53),
          buildStationDivider(top: 399.53),
          buildStationDivider(top: 496.53),
          buildStationInfo(
              left: 48.28, top: 158, stationName: '101 역' + " " * 34),
          buildStationInfo(
              left: 48.28, top: 250.50, stationName: '202 역' + " " * 34),
          buildStationInfo(
              left: 48, top: 347.30, stationName: '612 역' + " " * 34),
          buildStationInfo(
              left: 48.13, top: 444.10, stationName: '511 역' + " " * 34),
          buildFooterText(),
        ],
      ),
    );
  }

  Positioned buildTitleSection() {
    return Positioned(
      left: 13,
      top: 76,
      child: Row(
        children: [
          // 이미지 추가
          Image.asset(
            'assets/images/arrow.png', // 이미지 경로
            width: 24, // 이미지의 가로 크기
            height: 24, // 이미지의 세로 크기
          ),
          SizedBox(width: 18), // 텍스트와 이미지 간의 간격
          Text(
            '즐겨찾기',
            style: TextStyle(
              color: Color(0xFF22536F),
              fontSize: 24,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildStationDivider({required double top}) {
    return Positioned(
      left: 15,
      top: top,
      child: Container(
        width: 367,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFFD5D5D5)),
          ),
        ),
      ),
    );
  }

  Positioned buildStationInfo({
    required double left,
    required double top,
    required String stationName,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Row(
        children: [
          buildSquareIcon(),
          SizedBox(width: 23),
          Text(
            stationName,
            style: TextStyle(
              color: Color(0xFF676363),
              fontSize: 20,
              fontFamily: 'Roboto',
            ),
          ),
          Image.asset(
            'assets/images/icon.png', // 이미지 경로 지정
            width: 24, // 이미지의 크기 조정
            height: 24, // 이미지의 크기 조정
          ),
        ],
      ),
    );
  }

  Positioned buildFooterText() {
    return Positioned(
      left: 141,
      top: 750,
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
    );
  }

  Container buildSquareIcon() {
    return Container(
      width: 27.39,
      height: 32.15,
      decoration: BoxDecoration(
        color: Color(0xFF387394),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 2.98,
            top: 9.53,
            child: Container(
              width: 21.43,
              height: 11.31,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Positioned(
            left: 6.85,
            top: 4.47,
            child: Container(
              width: 13.69,
              height: 2.68,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: 2.98,
            top: 23.22,
            child: Container(
              width: 3.87,
              height: 5.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: 20.54,
            top: 23.22,
            child: Container(
              width: 3.87,
              height: 5.06,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

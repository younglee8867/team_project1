import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatefulWidget {
  @override
  _FlutterAppState createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);
  final ValueNotifier<double> _widthFactor = ValueNotifier<double>(1.0);

  @override
  void dispose() {
    _dark.dispose();
    _widthFactor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                _buildTopBar(),
                _buildButtonRow(),
                _buildTravelDetails(),
                _buildStationIndicators(),
                _buildExtraInfo(),
                _buildBottomText(),
              ],
            ),
          ),
        );
      },
    );
  }
}

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
      child: Row(
        children: [
          _buildTopStatus(isDark),
          _buildBottomText(),
          _buildButtons(isDark),
          _buildTravelDetails(isDark),
          _buildStationIndicators(isDark),
          _buildExtraInfo(isDark),
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('최소 거리 순', isMinDistanceSelected),
          _buildButton('최소 환승 순', !isMinDistanceSelected),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color textColor, Color borderColor) {
    return GestureDetector(
      onTap: () {
        // 버튼 클릭 시 동작을 정의하세요
      },
      child: Container(
        width: 120,
        height: 40,
        decoration: ShapeDecoration(
          color: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(width: 1, color: borderColor),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: borderColor,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildTravelDetails(bool isDark) {
    return Positioned(
      left: 60,
      top: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('소요 시간',
              style: TextStyle(color: Color(0xFF979797), fontSize: 16)),
          SizedBox(height: 10),
          // 아래 줄들은 '4분' 텍스트, 세로선, 인디케이터를 숨기기 위해 제거되었습니다.
          // Text('4 분', style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 45)),
          // SizedBox(height: 20),
          // Container(width: 7, height: 145, color: Color(0xFF856869)),
          // Positioned(left: 60, top: 308, child: _circleIndicator(Color(0xFF846868))),
          // Positioned(left: 60, top: 444, child: _circleIndicator(Color(0xFF856869))),
          // Positioned(left: 76, top: 318, child: Text('1', style: TextStyle(color: Colors.white, fontSize: 20))),
          // Positioned(left: 76, top: 454, child: Text('1', style: TextStyle(color: Colors.white, fontSize: 20))),
          // Positioned(left: 126, top: 318, child: Text('101', style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 32))),
          // Positioned(left: 126, top: 453, child: Text('103', style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 32))),
        ],
      ),
    );
  }

  Widget _circleIndicator(Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: ShapeDecoration(
        color: color,
        shape: OvalBorder(),
      ),
    );
  }

  Widget _buildStationIndicators(bool isDark) {
    return Positioned(
      left: 131,
      top: 345,
      child: _stationInfo('190 방면   |    빠른 하차 ', '5-2, 10-4', isDark),
    );
  }

  Widget _buildStationIndicators() {
    return Padding(
      padding: const EdgeInsets.only(left: 131.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '190 방면   |    빠른 하차 ',
            style: TextStyle(color: Color(0xFF979797), fontSize: 12),
          ),
          Text(
            '5-2, 10-4',
            style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraInfo(bool isDark) {
    return Positioned(
      left: 199,
      top: 240,
      child: Text(
        '|   환승 없음  |  비용 200원',
        style: TextStyle(color: Color(0xFF979797), fontSize: 15),
      ),
    );
  }

  TextStyle _textStyle(double size, Color color) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'Roboto', // Changed from 'Kode Mono' to 'Roboto'
      letterSpacing: 0.5,
    );
  }


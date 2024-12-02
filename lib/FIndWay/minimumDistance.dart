// 최소거리화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(minimumDistance());
}

class minimumDistance extends StatefulWidget {
  @override
  _minimumDistance createState() => _minimumDistance();
}

class _minimumDistance extends State<minimumDistance> {
  bool isMinDistanceSelected = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
          ),
          title: Text(
            '길찾기',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff22536F),
            ),
          ).tr(),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                _buildButtonRow(),
                _buildTravelDetails(),
                 _circleIndicator(Color(0xFF856869)),
                _buildStationIndicators(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildButton('최소 거리 순', isMinDistanceSelected),
          SizedBox(width: 30),
          _buildButton('최소 환승 순', !isMinDistanceSelected),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMinDistanceSelected = (text == '최소 거리 순');
        });
      },
      child: Container(
        width: 120,
        height: 40,
        decoration: ShapeDecoration(
          color: isSelected ? Color(0xFF397394) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(width: 1, color: Color(0xFF397394)),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Color(0xFF397394),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTravelDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 0),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '소요 시간',
              style: TextStyle(color: Color(0xFF979797), fontSize: 16)
            ),
            Text(
              '4분',
              style: TextStyle(color: Color(0xFF4C4C4C), fontSize: 45)
            )
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
        SizedBox(width: 100),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            '|   환승 없음  |  비용 200원',
            style: TextStyle(color: Color(0xFF979797), fontSize: 15),
          ),
        ),
      ],)
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
}

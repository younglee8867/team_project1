import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatefulWidget {
  @override
  _FlutterAppState createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  bool isMinDistanceSelected = true;

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
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          Text(
            '길찾기',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
      padding: const EdgeInsets.only(left: 60.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('소요 시간',
              style: TextStyle(color: Color(0xFF979797), fontSize: 16)),
          SizedBox(height: 10),
          Text('4 분', style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 45)),
          SizedBox(height: 20),
          Container(width: 7, height: 145, color: Color(0xFF856869)),
          Positioned(
            left: 60,
            top: 308,
            child: _circleIndicator(Color(0xFF846868)),
          ),
          Positioned(
            left: 60,
            top: 444,
            child: _circleIndicator(Color(0xFF856869)),
          ),
          Positioned(
            left: 76,
            top: 318,
            child:
                Text('1', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          Positioned(
            left: 76,
            top: 454,
            child:
                Text('1', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          Positioned(
            left: 126,
            top: 318,
            child: Text('101',
                style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 32)),
          ),
          Positioned(
            left: 126,
            top: 453,
            child: Text('103',
                style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 32)),
          ),
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

  Widget _buildExtraInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 199.0, top: 10),
      child: Text(
        '|   환승 없음  |  비용 200원',
        style: TextStyle(color: Color(0xFF979797), fontSize: 15),
      ),
    );
  }

  Widget _buildBottomText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Text(
          '스마트 환승철',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF387394),
            fontSize: 14,
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }
}

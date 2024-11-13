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
    return ValueListenableBuilder<bool>(
      valueListenable: _dark,
      builder: (context, isDark, child) {
        return MaterialApp(
          theme: isDark ? ThemeData.dark() : ThemeData.light(),
          home: ValueListenableBuilder<double>(
            valueListenable: _widthFactor,
            builder: (context, factor, child) {
              return Scaffold(
                backgroundColor: isDark
                    ? Colors.black
                    : const Color.fromARGB(255, 255, 225, 225),
                appBar: AppBar(
                  title: Text('Flutter App'),
                  actions: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode),
                        Switch(
                          value: isDark,
                          onChanged: (value) => _dark.value = value,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    DropdownButton<double>(
                      value: factor,
                      onChanged: (value) {
                        if (value != null) {
                          _widthFactor.value = value;
                        }
                      },
                      items: [
                        DropdownMenuItem(value: 0.5, child: Text('Size: 50%')),
                        DropdownMenuItem(value: 0.75, child: Text('Size: 75%')),
                        DropdownMenuItem(value: 1.0, child: Text('Size: 100%')),
                      ],
                      underline: Container(),
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                body: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * factor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: MinDistanceWidget(isDark: isDark)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class MinDistanceWidget extends StatelessWidget {
  final bool isDark;

  MinDistanceWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Adjust the size based on screen size for better responsiveness
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 1.2;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
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

  Widget _buildTopStatus(bool isDark) {
    return Positioned(
      left: 5,
      top: 10,
      right: 5,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(top: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '9:41',
                textAlign: TextAlign.center,
                style: _textStyle(17, isDark ? Colors.white : Colors.black),
              ),
            ),
            Container(width: 124, height: 10), // Spacer
            Container(
              width: 27.33,
              height: 13,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: isDark ? Colors.white : Colors.black),
                borderRadius: BorderRadius.circular(4.3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: 21,
                  height: 9,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: Center(
        child: Text(
          '스마트 환승철',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF387394),
            fontSize: 14,
            letterSpacing: 5,
            fontFamily: 'Roboto', // Changed from 'Kode Mono' to 'Roboto'
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(bool isDark) {
    return Positioned(
      left: 37,
      top: 140,
      right: 37,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('최소 거리 순', isDark ? Colors.white : Colors.black,
              Color(0xFF397394)),
          _buildButton('최소 환승 순', Color(0xFF397394),
              isDark ? Colors.white : Colors.black),
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
          Text('소요 시간', style: _textStyle(16, Color(0xFF979797))),
          SizedBox(height: 10),
          Text('4 분', style: _textStyle(45, Color(0xFF4B4B4B))),
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
            child: Text('1', style: _textStyle(20, Colors.white)),
          ),
          Positioned(
            left: 76,
            top: 454,
            child: Text('1', style: _textStyle(20, Colors.white)),
          ),
          Positioned(
            left: 126,
            top: 318,
            child: Text('101', style: _textStyle(32, Color(0xFF4B4B4B))),
          ),
          Positioned(
            left: 126,
            top: 453,
            child: Text('103', style: _textStyle(32, Color(0xFF4B4B4B))),
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

  Widget _buildStationIndicators(bool isDark) {
    return Positioned(
      left: 131,
      top: 345,
      child: _stationInfo('190 방면   |    빠른 하차 ', '5-2, 10-4', isDark),
    );
  }

  Widget _stationInfo(String text, String boldText, bool isDark) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: _textStyle(12, Color(0xFF979797)),
          ),
          TextSpan(
            text: boldText,
            style: _textStyle(12, Color(0xFF4F4F4F)),
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
        style: _textStyle(15, Color(0xFF979797)),
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
}

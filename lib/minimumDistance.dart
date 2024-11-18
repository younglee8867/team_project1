import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatefulWidget {
  const FlutterApp({super.key});

  @override
  _FlutterAppState createState() => _FlutterAppState();
}

class _FlutterAppState extends State<FlutterApp> {
  bool isMinDistanceSelected = true;

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
                  title: const Text('Flutter App'),
                  actions: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode),
                        Switch(
                          value: isDark,
                          onChanged: (value) => _dark.value = value,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<double>(
                      value: factor,
                      onChanged: (value) {
                        if (value != null) {
                          _widthFactor.value = value;
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 0.5, child: Text('Size: 50%')),
                        DropdownMenuItem(value: 0.75, child: Text('Size: 75%')),
                        DropdownMenuItem(value: 1.0, child: Text('Size: 100%')),
                      ],
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                body: Center(
                  child: SizedBox(
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
=======
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
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
class MinDistanceWidget extends StatelessWidget {
  final bool isDark;

  const MinDistanceWidget({super.key, required this.isDark});

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
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
=======
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
      child: Row(
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
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

<<<<<<< HEAD
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
            SizedBox(width: 124, height: 10), // Spacer
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
    return const Positioned(
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
              const Color(0xFF397394)),
          _buildButton('최소 환승 순', const Color(0xFF397394),
              isDark ? Colors.white : Colors.black),
=======
  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('최소 거리 순', isMinDistanceSelected),
          _buildButton('최소 환승 순', !isMinDistanceSelected),
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
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
<<<<<<< HEAD
          Text('소요 시간', style: _textStyle(16, const Color(0xFF979797))),
          const SizedBox(height: 10),
          Text('4 분', style: _textStyle(45, const Color(0xFF4B4B4B))),
          const SizedBox(height: 20),
          Container(width: 7, height: 145, color: const Color(0xFF856869)),
          Positioned(
            left: 60,
            top: 308,
            child: _circleIndicator(const Color(0xFF846868)),
          ),
          Positioned(
            left: 60,
            top: 444,
            child: _circleIndicator(const Color(0xFF856869)),
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
            child: Text('101', style: _textStyle(32, const Color(0xFF4B4B4B))),
          ),
          Positioned(
            left: 126,
            top: 453,
            child: Text('103', style: _textStyle(32, const Color(0xFF4B4B4B))),
          ),
=======
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
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
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
        shape: const OvalBorder(),
      ),
    );
  }

  Widget _buildStationIndicators() {
    return Padding(
      padding: const EdgeInsets.only(left: 131.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
          TextSpan(
            text: text,
            style: _textStyle(12, const Color(0xFF979797)),
          ),
          TextSpan(
            text: boldText,
            style: _textStyle(12, const Color(0xFF4F4F4F)),
=======
          Text(
            '190 방면   |    빠른 하차 ',
            style: TextStyle(color: Color(0xFF979797), fontSize: 12),
          ),
          Text(
            '5-2, 10-4',
            style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 12),
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
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
<<<<<<< HEAD
        style: _textStyle(15, const Color(0xFF979797)),
=======
        style: TextStyle(color: Color(0xFF979797), fontSize: 15),
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
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

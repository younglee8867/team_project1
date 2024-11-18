// 1-1 역정보
// <구현> : 변하는 값들
// 시간되면 역정보, 시설정보, 편의시설 앞에 아이콘..

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: searchStaInfo(),
        ),
      ),
    );
  }
}

class searchStaInfo extends StatefulWidget{
  @override
  _searchStaInfo createState() => _searchStaInfo();
}

class _searchStaInfo extends State<searchStaInfo> {

    // 즐찾 이미지
  String imagePath = '../assets/images/favStar.png';

  // Function to toggle the image
  void toggleImage() {
    setState(() {
      imagePath = imagePath == '../assets/images/favStar.png'
          ? '../assets/images/favStarFill.png' // New image path
          : '../assets/images/favStar.png';
    });
  }

    // 스타일 속성 정의(제목)
  final TextStyle commonTextStyle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 15,
    fontFamily: 'Roboto',
    height: 0.5,
    letterSpacing: 0.50,
    fontWeight: FontWeight.w800,
  );

  final TextStyle detailTextStyleTitle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 15,
    fontFamily: 'Roboto',
    height: 0.10,
    letterSpacing: 0.50,

  );

  // 스타일 속성 정의(상세 내용)
  final TextStyle detailTextStyle = TextStyle(
        color: Color(0xFF676363),
        fontSize: 15,
        fontFamily: 'Roboto',
        height: 0.10,
        letterSpacing: 0.50,
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          //width: screenWidth *0.3,
          //height: screenHeight *0.5,
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                child: Container(
                  width: 419,
                  height: 188,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('../assets/images/StationMap.png'), // 이미지 경로 확인
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  
                ),
              ),
              // 지도이미지
             Positioned(
                  left: 22,
                  top: 40,
                  child: Container(
                    width: 50, // 필요에 따라 너비를 지정하세요.
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF22536F),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                 // 노선도(동그라미)
              Positioned(
                left: 136,
                top: 161,
                child: Container(
                  width: 140,
                  height: 135,
                  decoration: ShapeDecoration(
                    color: Color(0xFF885D53),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 144,
                top: 168,
                child: Container(
                  width: 125,
                  height: 121,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(),
                  ),
                ),
              ),
              // 노선도 안 숫자
              Positioned(
                left: 178,
                top: 175,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 100,
                    fontFamily: 'Roboto',
                    height: 0,
                    letterSpacing: 0.50,
                  ),
                  child: Text('9')
                ),
              ),
              // 동그라미 밑 역 이름
              Positioned(
                left: 158,
                top: 316,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    height: 0.5,
                    letterSpacing: 0.50,
                  ),
                  child: Text('901 역')
                ),
              ),
              // 도착역 박스
              Positioned(
                left: 118,
                top: 356,
                child: Container(
                  width: 80,
                  height: 31,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 80,
                          height: 31,
                          padding: const EdgeInsets.all(12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFF686868),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      // 출발역
                      Positioned(
                        left: 18,
                        top: 13,
                        child: GestureDetector(
                           onTap: () {
                            Navigator.pop(context); // 구현 : 길찾기의 출발역으로
                          },
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              height: 0.5,
                            ),
                            child: Text('출발역')
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 도착역 박스
              Positioned(
                left: 214,
                top: 356,
                child: Container(
                  width: 80,
                  height: 31,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 80,
                          height: 31,
                          padding: const EdgeInsets.all(12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFF686868),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      // 도착역
                      Positioned(
                        left: 18,
                        top: 13,
                        child: GestureDetector(
                           onTap: () {
                            Navigator.pop(context); // 구현 : 길찾기의 도착역으로
                          },
                          child: DefaultTextStyle(
                            //'도착역',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              height: 0.5,
                            ),
                            child: Text('도착역'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 400,
                top: 339,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    //child: Stack(children: [
                    //,
                    //]),
                  ),
                ),
              ),
               Positioned(
                  top: 250,
                  right: 32,
                  child: GestureDetector(
                      onTap: toggleImage,
                      child: SizedBox(
                          width: imagePath == '../assets/images/favStar.png' ? 24.0 : 27.0,
                          height: imagePath == '../assets/images/favStar.png' ? 24.0 : 27.0,
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              Positioned( // 구현 : 화살표 누르면 이전역, 다음역 정보 뜨게?..가능하면..?
                left: 392,
                top: 306,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('../assets/images/Chevron_left_right.png'), // 이미지 경로 확인
                      fit: BoxFit.cover,
                    ),
                  ),
                  transform: Matrix4.rotationY(3.14159),
                ),
              ),
              Positioned(
                left: 10,
                top: 306,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('../assets/images/Chevron_left_right.png'), // 이미지 경로 확인
                      fit: BoxFit.cover,
                     
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 316,
                child: DefaultTextStyle(
                     // 구현 : 바뀌는 값(다음역)
                  style: commonTextStyle,
                  child: Text('902 역')
                ),
                
              ),
              Positioned(
                left: 34,
                top: 316,
                child: DefaultTextStyle(
                  //'900 역', // 구현 : 바뀌는 값(이전역)
                  style: commonTextStyle,
                  child: Text('900 역')
                ),
              ),
              Positioned(
                left: 35,
                top: 517,
                child: DefaultTextStyle(
                  //'시설 정보',
                  textAlign: TextAlign.center,
                  style: commonTextStyle,
                  child: Text('시설 정보'),
                ),
              ),
              Positioned(
                left: 39,
                top: 422,
                child: DefaultTextStyle(
                  //'역 정보',
                  style: commonTextStyle,
                  child: Text('역 정보')
                  
                ),
              ),
              // 날씨 정보
              Positioned(
                left: 35,
                top: 760,
                child: DefaultTextStyle(
                  //'날씨 정보',
                 style: commonTextStyle,
                 child: Text('날씨 정보')
                ),
              ),
              Positioned(
                left: 35,
                top: 655,
                child: DefaultTextStyle(
                  //'편의 시설',
                  textAlign: TextAlign.center,
                  style: commonTextStyle,
                  child: Text('편의 시설')
                ),
              ),
              Positioned(
                left: 35,
                top: 637,
                child: Container(
                  width: 326,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFE4E4E4),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 741,
                child: Container(
                  width: 326,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFE4E4E4),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 500,
                child: Container(
                  width: 326,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFE4E4E4),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 457,
                child: DefaultTextStyle(
                  style: detailTextStyleTitle, // DefaultTextStyle 적용
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '배차시간 ',
                          style: detailTextStyle, // 개별 스타일
                        ),
                        TextSpan(
                          text: '7분', // 바뀌는 값
                          style: detailTextStyle.copyWith(fontWeight: FontWeight.bold), // 덮어쓰기
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 189,
                top: 457,
                child: DefaultTextStyle(
                  style: detailTextStyleTitle, // DefaultTextStyle 적용
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '빠른하차 ',
                          style: detailTextStyle, // 개별 스타일
                        ),
                        TextSpan(
                          text: '3-1  4-3', // 바뀌는 값
                          style: detailTextStyle.copyWith(fontWeight: FontWeight.bold), // 덮어쓰기
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
             Stack(
                children: [
                
                    Positioned(
                      left: 40,
                      top: 558,
                      child: DefaultTextStyle(
                        style: detailTextStyleTitle, // DefaultTextStyle 적용
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '내리는문 ',
                              ),
                              TextSpan(
                                text: '오른쪽', // 바뀌는 값
                                style: detailTextStyle.copyWith(fontWeight: FontWeight.bold), // 덮어쓰기
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                     Positioned(
                      left: 189,
                      top: 558,
                      child: DefaultTextStyle(
                        style: detailTextStyleTitle, // DefaultTextStyle 적용
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '화장실 ',
                              ),
                              TextSpan(
                                text: '50m', // 바뀌는 값
                                style: detailTextStyle.copyWith(fontWeight: FontWeight.bold), // 덮어쓰기
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 595,
                      child: DefaultTextStyle(
                        style: detailTextStyleTitle, // DefaultTextStyle 적용
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '플랫폼 ',
                              ),
                              TextSpan(
                                text: '양쪽', // 바뀌는 값
                                style: detailTextStyle.copyWith(fontWeight: FontWeight.bold), // 덮어쓰기
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              // 구현 : 바뀌는 값(역 마다 편의시설)
              Stack(
                
                children: [
                  // 첫 번째 텍스트 묶음
                  Positioned(
                    left: 40,
                    top: 691,
                    child: DefaultTextStyle(
                      //'편의점 / 카페',
                      style: detailTextStyle,
                      child: Text('편의점 / 카페')
                    ),
                    
                  ),
                  Positioned(
                    left: 40,
                    top: 721,
                    child: DefaultTextStyle(
                      //'물품보관소',
                      style: detailTextStyle,
                      child: Text('물품보관소')
                    ),
                  ),
                  // 두 번째 텍스트 묶음
                  Positioned(
                    left: 189,
                    top: 691,
                    child: DefaultTextStyle(
                      //'유실물센터',
                      style: detailTextStyle,
                      child: Text('유실물센터')
                    ),
                  ),
                  Positioned(
                    left: 189,
                    top: 721,
                    child: DefaultTextStyle(
                      //'엘리베이터',
                      style: detailTextStyle,
                      child: Text('엘리베이터'),
                    ),
                  ),
                ],
              ),

             
            // 날씨 상세 구현 : 역마다 바뀌는 값              
              Positioned(
                left: 40,
                top: 792,
                child: Container(
                  width: 332,
                  height: 94,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // 그림자 색상
                        offset: Offset(2, 6), // 아래쪽으로만 그림자
                        blurRadius: 7, // 흐림 정도
                        spreadRadius: 0.3, // 바닥 면 그림자 크기 조정
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 55,
                top: 805,
                child: Container(
                  width: 18,
                  height: 21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('../assets/images/subway_small.png'), // 이미지 경로 확인
                      fit: BoxFit.cover,
                     
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 815,
                child: DefaultTextStyle(
                          //'901 역',
                          style: TextStyle(
                            color: Color(0xFF676363),
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            height: 0.5,
                            letterSpacing: 0.50,
                          ),
                          child: Text('901 역'),
                ),
              ),
              Positioned(
                left: 219,
                top: 864,
                child: SizedBox(
                  width: 116.14,
                  height: 20.70,
                  child: DefaultTextStyle(
                    //'체감 10.8° / 습도 95%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Roboto',
                      height: 0.20,
                      letterSpacing: 0.50,
                    ),
                    child: Text('체감 10.8° / 습도 95%'),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 828,
                child: SizedBox(
                  width: 85.29,
                  height: 20.70,
                  child: DefaultTextStyle(
                    //'10.8°',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      height: 0.5,
                      letterSpacing: 0.50,
                    ),
                    child: Text('10.8°'),
                  ),
                ),
              ),
              Positioned(
                left: 59,
                top: 837,
                child: Container(
                  width: 140.75,
                  height: 39.67,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 49.52,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFF4D1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 99.04,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9F5D2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 53,
                        top: 8,
                        child: SizedBox(
                          width: 33.88,
                          height: 20.70,
                          child: Text(
                            '미세먼지',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD1E9FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7.82,
                        top: 8,
                        child: SizedBox(
                          width: 25.20,
                          height: 20.70,
                          child: Text(
                            '강수량',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9.56,
                        top: 25,
                        child: SizedBox(
                          width: 21.72,
                          height: 20.70,
                          child: Text(
                            '0mm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 61.69,
                        top: 24,
                        child: SizedBox(
                          width: 16.51,
                          height: 20.70,
                          child: Text(
                            '나쁨',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFE69800),
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111.21,
                        top: 24,
                        child: SizedBox(
                          width: 16.51,
                          height: 20.70,
                          child: Text(
                            '보통',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4A7700),
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 106.86,
                        top: 8,
                        child: SizedBox(
                          width: 25.20,
                          height: 20.70,
                          child: Text(
                            '자외선',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                    ],
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
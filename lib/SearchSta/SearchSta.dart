// 역 검색 화면
// <구현> : 변하는 값들
// 11.17 화면은 넘어가는데 넘어간 화면에 노란 밑줄이 뜸
//-> 요거 화면 크기가 넘어가서 뜨는거더라구요

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';

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
          child: _searchSta(),
        ),
      ),
    );
  }
}

class _searchSta extends StatefulWidget {
  @override
  searchSta createState() => searchSta();
}

class searchSta extends State<_searchSta> {
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
                  left: 26, // 좌측 위치 설정 (필요에 맞게 조정)
                  top: 90, // 상단 위치 설정 (필요에 맞게 조정)
                  child: Container(
                    width: 360, // 가로 길이 (필요에 맞게 조정)
                    height: 56, // 세로 길이 (필요에 맞게 조정)
                    decoration: BoxDecoration(
                      color: Colors.white, // 배경색 흰색
                      borderRadius: BorderRadius.circular(28), // 모서리 둥글게
                      border: Border.all(
                        color: const Color.fromRGBO(0, 57, 115, 148), // 테두리 색상
                        width: 2, // 테두리 두께
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0), // 왼쪽 마진 추가
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // 구현 : 메뉴바 나오게
                            },
                            child: Image.asset(
                              '../assets/images/menu.png',
                              width: 48,
                              height: 48,
                            ),
                          ),
                          SizedBox(width: 16), // 이미지와 텍스트 사이 간격

                          // 검색 텍스트 입력 필드
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '역 검색',
                                hintStyle: TextStyle(color: Color(0xFFABABAB)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 검색 아이콘
                          IconButton(
                            padding: EdgeInsets.only(right: 20.0),
                            icon: Icon(Icons.search, color: Color(0xFF386B88)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        searchStaInfo()), // 이동할 페이지를 여기에 지정
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, -10), // 전체 그룹을 이동시킬 위치
                      child: Stack(
                        children: [
                          Positioned(
                            top: 200,
                            left: 40,
                            child: Container(
                              width: 25,
                              height: 28,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      '../assets/images/subway_small.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 240,
                            left: 35,
                            child: Container(
                              width: 360,
                              height: 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('../assets/images/line.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            right: 40,
                            child: GestureDetector(
                              onTap: toggleImage,
                              child: SizedBox(
                                width:
                                    imagePath == '../assets/images/favStar.png'
                                        ? 24.0
                                        : 27.0,
                                height:
                                    imagePath == '../assets/images/favStar.png'
                                        ? 24.0
                                        : 27.0,
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 198,
                            left: 80,
                            child: Text(
                              '101 역',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF676363),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 250,
                            left: 170,
                            child: Text(
                              '검색기록 삭제',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFACACAC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

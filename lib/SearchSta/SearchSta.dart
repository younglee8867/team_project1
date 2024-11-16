// 역 검색 화면
// <구현> : 변하는 값들

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
          child: _searchSta(),
        ),
      ),
    );
  }
}

class _searchSta extends StatefulWidget{
  @override
  searchSta createState() => searchSta();
}

class searchSta extends State<_searchSta> {
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
                          // 구현 : 검색 아이콘을 눌렀을 때의 동작
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

        )
      ), 
      ],
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // 회색 배경
            Container(color: Colors.grey[200]),

            // 둥근 모서리를 가진 사이드바
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Sidebar(),
            ),
          ],
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 여백 추가
          SizedBox(height: 50),

          // 메뉴 항목들
          MenuItem(text: '수도권', onPressed: () {}),
          MenuItem(text: '부산', onPressed: () {}),
          MenuItem(text: '대구', onPressed: () {}),
          MenuItem(text: '광주', onPressed: () {}),
          MenuItem(text: '대전', onPressed: () {}),

          Spacer(),

          // 설정 아이콘 및 언어 표시
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: Row(
              children: [
                Icon(Icons.settings, size: 24, color: Color(0xFF22536F)),
                SizedBox(width: 5),
                Text('En',
                    style: TextStyle(fontSize: 20, color: Color(0xFF22536F))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MenuItem({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF22536F),
              ),
            ),
            Divider(color: Color(0xFFD5D5D5), thickness: 1),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BonFire extends StatefulWidget {
  @override
  _BonFire createState() => _BonFire();
}

class _BonFire extends State<BonFire> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 GIF
          Container(
            width: double.infinity, // 화면 가로 전체
            height: double.infinity, // 화면 세로 전체
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover, // GIF가 화면을 꽉 채우도록
                image: AssetImage('assets/images/miniGame/bonFireAnimated.gif'),
              ),
            ),
          ),

          // 뒤로가기 버튼
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),

          // 텍스트 표시
          Positioned(
            top: 100,
            left: 100,
            child: Text(
              'r e l a x i n g. . . ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

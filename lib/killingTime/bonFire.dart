// 불멍 화면
// 11.24 모닥불 gif가 너무 빠름
import 'package:flutter/material.dart';

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
            width: double.infinity,  // 화면 가로 전체
            height: double.infinity, // 화면 세로 전체
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,  // GIF가 화면을 꽉 채우도록
                image: Image.asset(
                  'assets/images/miniGame/bonFireAnimated.gif',
                  fit: BoxFit.cover,
                ).image,
              ),
            ),
          ),

          // 뒤로가기
          Positioned(
            top: 40,  
            left: 16, 
            child: GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255), size: 30),
            ),
          ),
          Positioned(
            top: 100, 
            left: 100, 
            child: Text(
              'r e l a x i n g. . . ',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(128, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

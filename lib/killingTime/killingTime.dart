// 킬링타임 (게임,불멍 선택 화면)
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/bonFire.dart';
import 'package:flutter_application_1/killingTime/miniGame.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';

class KillingTimeGame extends StatefulWidget {
  @override
  _KillingTimeGame createState() => _KillingTimeGame();
}

class _KillingTimeGame extends State<KillingTimeGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '킬링타임',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 60.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ).tr(),
        backgroundColor: Color.fromARGB(204, 34, 83, 111),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 위에서 시작
          children: [
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppleGame()),
                );
              },
              child: Image.asset(
                'assets/images/miniGame/miniGame.png',
                fit: BoxFit.contain,
                width: 300,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '10을 만들어요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff978080),
              ),
            ).tr(),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BonFire()),
                );
              },
              child: Image.asset(
                'assets/images/miniGame/bonFire.png',
                fit: BoxFit.contain,
                width: 300,
                height: 200,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '불멍 타임!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff978080),
              ),
            ).tr(),
          ],
        ),
      ),
      // 하단바
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
      ),
    );
  }
}

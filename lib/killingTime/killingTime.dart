import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/bonFire.dart';
import 'package:flutter_application_1/killingTime/miniGame.dart';
// 한영변환
import 'package:easy_localization/easy_localization.dart';

//11.25 이미지 파일에서 ../ 제거!

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
            }
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '킬링타임',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 위에서 시작
          children: [
            SizedBox(height: 80),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

class RegionSettingsPage extends StatefulWidget {
  const RegionSettingsPage({super.key});

  @override
  State<RegionSettingsPage> createState() => _RegionSettingsPage();
}

class _RegionSettingsPage extends State<RegionSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
            backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
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
          '지역 설정',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: const [
            RegionButton(region: '수도권'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '부산'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '대구'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '광주'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '대전'),
            Divider(thickness: 1, height: 1),
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

class RegionButton extends StatelessWidget {
  final String region;

  const RegionButton({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ListTile(
      title: Text(
        region.tr(), // 번역 키를 통해 다국어 적용
        style: TextStyle(
          fontSize: 16,
          color: themeNotifier.isDarkMode ? Colors.white70 : Color(0xFF22536F),
          fontFamily: 'Roboto',
        ),
      ).tr(),
      onTap: () {
        // 버튼 눌렀을 때 별다른 동작 없음
      },
    );
  }
}

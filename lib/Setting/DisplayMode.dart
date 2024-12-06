import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/constants/displayMode.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const DisplayModePage());
}

class DisplayModePage extends StatefulWidget {
  const DisplayModePage({super.key});

  @override
  State<DisplayModePage> createState() => _DisplayModePageState();
}

class _DisplayModePageState extends State<DisplayModePage> {
  // 상태 변수
  bool isLightModeSelected = true;

  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38)
          : Colors.white, // 배경 색상 설정
        appBar: AppBar(
        backgroundColor:
            themeNotifier.isDarkMode ? Color.fromARGB(204, 34, 83, 111) : Color.fromARGB(204, 34, 83, 111),
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
          '화면 모드',
          style: TextStyle(
            color: themeNotifier.isDarkMode ? Colors.white : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/settings/displayLight.png',
                      width: 200,
                    ),
                    Radio<bool>(
                      value: false,
                      groupValue: themeNotifier.isDarkMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeNotifier.toggleTheme();
                        }
                      },
                    ),
                    Text(
                      'Light Mode',
                      style: TextStyle(
                        color:
                            themeNotifier.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                     Image.asset(
                      'assets/images/settings/displayDark.png',
                      width: 200,
                    ),
                    Radio<bool>(
                      value: true,
                      groupValue: themeNotifier.isDarkMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeNotifier.toggleTheme();
                        }
                      },
                    ),
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        color:
                            themeNotifier.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

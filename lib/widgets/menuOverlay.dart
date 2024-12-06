// 메뉴바 위젯
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

class MenuOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSearchTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onGameTap;
  final VoidCallback onSettingsTap;

  const MenuOverlay({
    required this.onClose,
    required this.onSearchTap,
    required this.onFavoritesTap,
    required this.onGameTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GestureDetector(
      onTap: onClose,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.97,
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Image.asset(
                    themeNotifier.isDarkMode ?
                    'assets/images/menuBar/menuBar_dark.png': 
                    'assets/images/menuBar/menuBar.png',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 100),
                  Column(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 160, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: onSearchTap,
                                child: Text(
                                  '길찾기',
                                  style: TextStyle(
                                    color: themeNotifier.isDarkMode ? const Color.fromARGB(228, 242, 242, 242) : Color(0xff22536F),
                                    fontSize: 16,
                                  ),
                                ).tr(),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 1,
                                color: Color(0xffD6D6D6),
                              ),
                              SizedBox(height: 50),
                              GestureDetector(
                                onTap: onFavoritesTap,
                                child: Text(
                                  '즐겨찾기',
                                  style: TextStyle(
                                    color: themeNotifier.isDarkMode ? const Color.fromARGB(228, 242, 242, 242) : Color(0xff22536F),
                                    fontSize: 16,
                                  ),
                                ).tr(),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 1,
                                color: Color(0xffD6D6D6),
                              ),
                              SizedBox(height: 50),
                              GestureDetector(
                                onTap: onGameTap,
                                child: Text(
                                  '킬링타임',
                                  style: TextStyle(
                                    color: themeNotifier.isDarkMode ? const Color.fromARGB(228, 242, 242, 242) : Color(0xff22536F),
                                    fontSize: 16,
                                  ),
                                ).tr(),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 1,
                                color: Color(0xffD6D6D6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 30),
                    child:Column(
                    mainAxisAlignment: MainAxisAlignment.end, // 아래쪽 정렬
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                            child: Image.asset(
                              themeNotifier.isDarkMode ?
                              'assets/images/menuBar/homeButton_dark.png' :
                              'assets/images/menuBar/homeButton.png',
                              width: 28,
                            ),
                          ),
                          SizedBox(width: 20),                         
                          GestureDetector(
                            onTap: onSettingsTap,
                            child: Image.asset(
                              themeNotifier.isDarkMode ?
                              'assets/images/menuBar/settings_button_dark.png' :
                              'assets/images/menuBar/settings_button.png',
                              width: 28,
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              context.setLocale(
                                context.locale.languageCode == 'ko' ? Locale('en') : Locale('ko'),
                              );
                            },
                            child: Image.asset(
                              themeNotifier.isDarkMode ?
                              'assets/images/menuBar/en_button_dark.png' :
                              'assets/images/menuBar/en_button.png',
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

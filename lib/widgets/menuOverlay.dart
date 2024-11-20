
import 'package:flutter/material.dart';

// 역 검색 : 검색창 왼쪽에 메뉴바 클릭시 왼쪽에서 메뉴 창 나타남(홈화면에서도 이용 가능할듯)
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
    return GestureDetector(
      onTap: onClose, // 메뉴 닫기 동작
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Image.asset(
                    '../assets/images/menuBar/menuBar.png',
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 120,
                    left: 20,
                    child: GestureDetector(
                      onTap: onSearchTap,
                      child: Image.asset(
                        '../assets/images/menuBar/menuBar_search.png',
                        width: 247,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 20,
                    child: GestureDetector(
                      onTap: onFavoritesTap,
                      child: Image.asset(
                        '../assets/images/menuBar/menuBar_Fav.png',
                        width: 247,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    left: 20,
                    child: GestureDetector(
                      onTap: onGameTap,
                      child: Image.asset(
                        '../assets/images/menuBar/menuBar_game.png',
                        width: 247,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 780,
                    left: 20,
                    child: GestureDetector(
                      onTap: onSettingsTap,
                      child: Image.asset(
                        '../assets/images/menuBar/settings_button.png',
                        width: 38,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 788,
                    left: 70,
                    child: Image.asset(
                      '../assets/images/menuBar/en_button.png',
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

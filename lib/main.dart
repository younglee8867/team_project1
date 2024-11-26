// 스플래시 화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_application_1/SearchSta/SearchSta.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';
import '../widgets/searchBar.dart';
import '../widgets/menuOverlay.dart';

import 'SearchSta/SearchStaInfo.dart';
import 'FindWay/StationMap.dart';
import 'Setting/Settings.dart';
import 'util/util.dart';
import 'favoriteSta.dart';
import 'killingTime/killingTime.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: 'assets/langs', // JSON 파일 경로
      fallbackLocale: const Locale('ko'), // 기본 언어를 한국어로 설정
      child: SmartSubway(),
    ),
  );
}

class SmartSubway extends StatelessWidget {
  const SmartSubway({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashScreen()
    );
  }
}

// 스플래시 스크린
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3 초 뒤에 다음 화면으로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });

    // 스플래시 화면 UI
    return Scaffold(
      backgroundColor: Color(0xff388FB4),
      body: Center(
        child: Image.asset(
          'assets/images/splashLogo.png', // 이미지 경로
          fit: BoxFit.cover,
          width: 250,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

// 홈화면
class _Home extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _searchHistory;
  bool _isMenuVisible = false;
  String? _selectedLine = '전체';

    void _toggleMenuVisibility() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

        // 검색 기록 삭제
  void _deleteSearchHistory() {
    setState(() {
      clearHistory(_searchHistory);
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (_isMenuVisible) {
                setState(() {
                  _isMenuVisible = false;
                });
              }
            },
            child: Column(
              children: [
                  SearchTopBar(
                    // 상단 - 검색바
                    controller: _searchController,
                    onSearch: (_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchStationPage(), // 페이지를 SearchStaInfoPage로 이동
                        ),
                      );
                    },
                    onMenuTap: _toggleMenuVisibility, // 메뉴 탭 기능 유지
                    onDelete: _deleteSearchHistory,
                  ),
                // 노선도 이미지 추가
              Expanded(
              child: Stack(
                children: [
                  // 노선도 이미지
                  InteractiveViewer(
                    boundaryMargin: EdgeInsets.all(20.0),
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Container(
                      child: Center(
                        child: Image.asset('assets/images/StationMap.png'),
                      ),
                    ),
                  ),
                  // 호선별 드롭박스
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xff397394),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedLine,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.white, size: 18),
                        dropdownColor: Color.fromARGB(255, 128, 180, 210),
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLine = newValue;
                          });
                        },
                        items: <String>[
                          '전체',
                          '1호선',
                          '2호선',
                          '3호선',
                          '4호선',
                          '5호선',
                          '6호선',
                          '7호선',
                          '8호선',
                          '9호선'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
          ),
          if (_isMenuVisible) // 좌측 - 메뉴바 카테고리별 이동
            MenuOverlay(
              onClose: _toggleMenuVisibility,
              onSearchTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StationMap()),
                );
              },
              onFavoritesTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FavoriteSta(favoriteStations: [])),
                );
              },
              onGameTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KillingTimeGame()),
                );
              },
              onSettingsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
        ],
      ),
    );
  }
}

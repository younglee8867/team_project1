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
import 'package:provider/provider.dart';
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
      child: MultiProvider(
        providers: [ // 상태관리
          ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
        ],
        child: SmartSubway(),
      ),
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

@override
Widget build(BuildContext context) {
  final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
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
              // 메뉴 아이콘과 검색 바
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 57, 115, 148),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // 메뉴 아이콘
                      GestureDetector(
                        onTap: _toggleMenuVisibility,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/menu.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      // 검색 텍스트 필드
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '역 검색'.tr(),
                            hintStyle: TextStyle(color: Color(0xFFABABAB)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchStationPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      // 검색 버튼
                      IconButton(
                        icon: const Icon(Icons.search, color: Color(0xFF386B88)),
                        onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchStationPage(),
                              ),
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              // 노선도 이미지와 드롭다운
              Expanded(
                child: Stack(
                  children: [
                    // 노선도 이미지
                    InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20.0),
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: Center(
                        child: Image.asset('assets/images/StationMap.jpg'),
                      ),
                    ),
                    
                    // 호선별 드롭다운
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff397394),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedLine,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 18,
                          ),
                          dropdownColor: const Color.fromARGB(255, 128, 180, 210),
                          style: const TextStyle(color: Colors.white),
                          underline: const SizedBox(),
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
                            '9호선',
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

        // 좌측 메뉴바 오버레이
        if (_isMenuVisible)
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
                  builder: (context) => FavoriteSta(),
                ),
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

// 역검색
//11.29 검색 기록을 SharedStationData에서 가져옴
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/killingTime.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

// 위젯
import '../widgets/searchBar.dart';
import '../widgets/searchResultItem.dart';
import '../widgets/menuOverlay.dart';

// 다른 화면 파일 or util
import '../SearchSta/SearchStaInfo.dart';
import '../FindWay/StationMap.dart';
import '../Setting/Settings.dart';
import '../util/util.dart';
import '../favoriteSta.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchStationPage(),
    );
  }
}

class SearchStationPage extends StatefulWidget {
  @override
  _SearchStationPageState createState() => _SearchStationPageState();
}

class _SearchStationPageState extends State<SearchStationPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _searchHistory; // 검색 기록 리스트
  late String _favImagePath;
  late bool isFavorite;
  bool _isMenuVisible = false; // 메뉴바 표시 여부

  // 초기값
  @override
  void initState() {
    super.initState();
    _loadSearchHistory(); // SharedStationData 사용
  }

  Future<void> _loadSearchHistory() async {
    setState(() {
      _searchHistory =
          SharedStationData.searchHistory; // SharedStationData에서 최신 데이터 로드
    });
  }

  // 메뉴 표시/숨기기 토글
  void _toggleMenuVisibility() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  // 즐겨찾기 표시 토글
  void _toggleFavImage(int index) {
    setState(() {
      SharedStationData.toggleFavoriteStatus(_searchHistory[index]['name']);
    });
  }

  // 검색 기록 추가
  void _addSearchHistory(String stationName) {
    setState(() {
      SharedStationData.addSearchHistory({
        "name": stationName,
        "isFavorite": false,
      });
      _searchHistory = SharedStationData.searchHistory;
    });
  }

  // 검색 기록 삭제
  void _deleteSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  // 숫자만 추출하는 함수
  String extractNumber(String input) {
    final RegExp numberRegex = RegExp(r'\d+'); // 숫자에 해당하는 정규식
    final match = numberRegex.firstMatch(input);
    return match?.group(0) ?? ''; // 숫자가 없으면 빈 문자열 반환
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
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
                  onSearch: (value) {
                    if (value.isNotEmpty) {
                      _addSearchHistory(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchStaInfo(
                            searchHistory: _searchHistory,
                            stationName: value,
                          ),
                        ),
                      ); // 돌아오면 갱신
                    }
                  },
                  onMenuTap: _toggleMenuVisibility,
                  onDelete: _deleteSearchHistory,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchHistory.length,
                    itemBuilder: (context, index) {
                      final record = _searchHistory[index];
                      return GestureDetector(
                        onTap: () {
                          final stationNumber = extractNumber(record['name']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchStaInfo(
                                stationName: stationNumber,
                                searchHistory: _searchHistory,
                              ),
                            ),
                          ); // 돌아오면 갱신
                        },
                        child: SearchResultItem(
                          stationName: record['name'] + " " + "역".tr(),
                          favImagePath: record['isFavorite']
                              ? 'assets/images/favStarFill.png'
                              : 'assets/images/favStar.png', // 상태에 따라 이미지 선택
                          onToggleFav: () => _toggleFavImage(index),
                          onSelect: () {
                            setState(() {
                              // 기록에 있는 역을 검색창으로
                              _searchController.text = record['name'];
                            });
                          },
                        ),
                      );
                    },
                  ),
                )
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
                          FavoriteSta(favoriteStations: _searchHistory)),
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
                  MaterialPageRoute(builder: (context) => settings()),
                );
              },
            ),
        ],
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

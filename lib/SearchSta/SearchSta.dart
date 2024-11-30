// 역검색
//11.29 검색 기록을 SharedStationData에서 가져옴
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/killingTime.dart';
import 'package:easy_localization/easy_localization.dart';

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
    isFavorite = false;
    _favImagePath = '../assets/images/favStar.png';
    _searchHistory = SharedStationData.searchHistory; // SharedStationData 사용
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
    });
  }

  // 검색 기록 삭제
  void _deleteSearchHistory() {
    setState(() {
      _searchHistory.clear();
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
                  onSearch: (value) {
                    if (value.isNotEmpty) {
                      _addSearchHistory(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchStaInfo(searchHistory: _searchHistory)),
                      );
                    }
                  },
                  onMenuTap: _toggleMenuVisibility,
                  onDelete: _deleteSearchHistory,
                ),
                Expanded(
                  // 가운데 - 검색기록 내역
                  child: ListView.builder(
                    itemCount: _searchHistory.length,
                    itemBuilder: (context, index) {
                      final record = _searchHistory[index];
                      return SearchResultItem(
                        stationName: record['name'] + " " +"역".tr(),
                        favImagePath: record['isFavorite']
                            ? 'assets/images/favStarFill.png'
                            : 'assets/images/favStar.png', // 상태에 따라 이미지 선택
                        onToggleFav: () => _toggleFavImage(index), // 인덱스를 전달
                        onSelect: () {
                          setState(() {
                            // 기록에 있는 역을 검색창으로
                            _searchController.text = record['name'];
                          });
                        },
                      );
                    },
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
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
        ],
      ),
    );
  }
}

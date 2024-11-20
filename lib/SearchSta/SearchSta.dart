import 'package:flutter/material.dart';

// 위젯
import '../widgets/searchBar.dart';
import '../widgets/searchResultItem.dart';
import '../widgets/menuOverlay.dart';

// 다른 화면 파일 or util
import '../SearchSta/SearchStaInfo.dart';
import '../StationMap.dart';
import '../Setting/Settings.dart';
import '../util/util.dart';

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
  String _currentImage = '../assets/images/menu.png';

  // 초기값
  @override
  void initState() {
    super.initState();
    isFavorite = false;
    _favImagePath = '../assets/images/favStar.png';
    _searchHistory = []; // 검색 기록 초기화
  }

  void _toggleMenuVisibility() {
    setState(() {
      _isMenuVisible = !_isMenuVisible; // 메뉴 표시/숨기기 토글
    });
  }

  void _toggleFavImage(int index) {
    setState(() {
      _searchHistory[index]['isFavorite'] = !_searchHistory[index]['isFavorite'];
    });
  }

  void _addSearchHistory(String stationName) {
    setState(() {
        addSearchHistory(_searchHistory, stationName);
    });
  }

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
                _isMenuVisible = false; // 메뉴 닫기
              });
            }
          },
          child: Column(
            children: [
              SearchTopBar(
                controller: _searchController,
                onSearch: (value) {
                  if (value.isNotEmpty) {
                    _addSearchHistory(value);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => searchStaInfo()),
                    );
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
                    return SearchResultItem(
                      stationName: record['name'],
                      favImagePath: record['isFavorite']
                          ? 'assets/images/favStarFill.png'
                          : 'assets/images/favStar.png', // 상태에 따라 이미지 선택
                      onToggleFav: () => _toggleFavImage(index), // 인덱스를 전달
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );*/
              },
              onGameTap: () {
                // Navigate to the game page (to be implemented)
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










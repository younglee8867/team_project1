// 역검색
import 'package:flutter/material.dart';
import 'package:flutter_application_1/killingTime/killingTime.dart';
import 'package:provider/provider.dart';

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

class SearchStationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // 메뉴 닫기
              if (searchHistoryProvider.isMenuVisible) {
                searchHistoryProvider.toggleMenuVisibility();
              }
            },
            child: Column(
              children: [
                // 상단 검색바
                SearchTopBar(
                  controller: TextEditingController(),
                  onSearch: (value) {
                    if (value.isNotEmpty) {
                      searchHistoryProvider.addSearchHistory(value);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => searchStaInfo(
                            searchHistory: searchHistoryProvider.searchHistory,
                          ),
                        ),
                      );*/
                    }
                  },
                  onMenuTap: searchHistoryProvider.toggleMenuVisibility,
                  onDelete: searchHistoryProvider.clearHistory,
                ),

                // 검색 기록 표시
                Expanded(
                  child: ListView.builder(
                    itemCount: searchHistoryProvider.searchHistory.length,
                    itemBuilder: (context, index) {
                      final record =
                          searchHistoryProvider.searchHistory[index];
                      return SearchResultItem(
                        stationName: record['name'],
                        favImagePath: record['isFavorite']
                            ? 'assets/images/favStarFill.png'
                            : 'assets/images/favStar.png',
                        onToggleFav: () =>
                            searchHistoryProvider.toggleFavorite(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 메뉴 오버레이 표시
          if (searchHistoryProvider.isMenuVisible)
            MenuOverlay(
              onClose: searchHistoryProvider.toggleMenuVisibility,
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
                    builder: (context) => FavoriteSta(
                      //favoriteStations: searchHistoryProvider.searchHistory,
                    ),
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
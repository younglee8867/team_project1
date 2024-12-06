// 즐겨찾기 화면
//11.29 SharedStationData를 통해 favoriteOnly를 관리
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';
import 'package:flutter_application_1/main.dart';
import './util/util.dart';
import './widgets//searchResultItem.dart';
import 'package:provider/provider.dart';
import './constants/displayMode.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoriteSta extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteStations;

  const FavoriteSta({
    required this.favoriteStations,
  });

  @override
  _FavoriteStaState createState() => _FavoriteStaState();
}

class _FavoriteStaState extends State<FavoriteSta> {
  late List<Map<String, dynamic>> favoriteOnly;

  @override
  void initState() {
    super.initState();
    // SharedStationData의 즐겨찾기 항목으로 초기화
    favoriteOnly = SharedStationData.favoriteStations;
  }

  void _toggleFavorite(int index) {
    setState(() {
      SharedStationData.toggleFavoriteStatus(favoriteOnly[index]['name']);
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
          '즐겨찾기',
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

      body: favoriteOnly.isEmpty
          ? Center(
              // 리스트에 항목이 없을 때
              child: Text(
                '즐겨찾기 항목이 없습니다.',
                style: TextStyle(fontSize: 16, color: themeNotifier.isDarkMode ? Colors.white70 : Colors.black87),
              ).tr(),
            )
          : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: favoriteOnly.length,
            itemBuilder: (context, index) {
              final record = favoriteOnly[index];

              return GestureDetector(
                onTap: () {
                  final stationNumber = extractNumber(record['name']); // 숫자 추출
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchStaInfo(
                        stationName: stationNumber, // 숫자만 전달
                        searchHistory: [],
                      ),
                    ),
                  );
                },
                child: SearchResultItem(
                  stationName: record['name'] + " " + "역".tr(),
                  favImagePath: record['isFavorite']
                      ? 'assets/images/favStarFill.png'
                      : 'assets/images/favStar.png',
                  onToggleFav: () {
                    setState(() {
                      SharedStationData.toggleFavoriteStatus(record['name']);
                    });
                  },
                  onSelect: () {
                    // 기록에 있는 역을 검색창으로
                    Navigator.pop(context, record['name']);
                  },
                ),
              );
            },
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

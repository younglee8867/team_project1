// 즐겨찾기 화면
//11.29 SharedStationData를 통해 favoriteOnly를 관리
import 'package:flutter/material.dart';
import './util/util.dart';
import './widgets//searchResultItem.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
            }
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '즐겨찾기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: favoriteOnly.isEmpty
          ? Center(
              // 리스트에 항목이 없을 때
              child: Text(
                '즐겨찾기 항목이 없습니다.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ).tr(),
            )
          : ListView.builder(
              // 리스트에 항목이 있을 때
              padding: const EdgeInsets.all(8.0),
              itemCount: favoriteOnly.length,
              itemBuilder: (context, index) {
                final record = favoriteOnly[index];
                return SearchResultItem(
                  stationName: record['name'] +" "+"역".tr(),
                  favImagePath: record['isFavorite']
                      ? 'assets/images/favStarFill.png'
                      : 'assets/images/favStar.png',
                  onToggleFav: () => _toggleFavorite(index), // 상태 변경
                  onSelect: () {
                    // 기록에 있는 역을 검색창으로
                    Navigator.pop(context, record['name']);
                  },
                );
              },
            ),
    );
  }
}

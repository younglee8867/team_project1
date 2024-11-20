// 11.20 즐겨찾기를 추가하고 다시 즐겨찾기 항목으로 갔을 때 뒤로가기 버튼이 안 먹힘(11.21 해결)
// 11.21 즐겨찾기 화면 내에서 별 클릭 이벤트 추가할 것

import 'package:flutter/material.dart';
import './widgets//searchResultItem.dart';

class FavoriteSta extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteStations;

  const FavoriteSta({
    required this.favoriteStations,
  });

  @override
  Widget build(BuildContext context) {
    // 즐겨찾기 항목만 필터링
    final favoriteOnly = favoriteStations.where((station) => station['isFavorite'] == true).toList();

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음');
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
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: favoriteOnly.isEmpty
            ? Center(
                child: Text(
                  '즐겨찾기 항목이 없습니다.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: favoriteOnly.length,
                itemBuilder: (context, index) {
                  final record = favoriteOnly[index];
                  return SearchResultItem(
                    stationName: record['name'],
                    favImagePath: record['isFavorite']
                        ? 'assets/images/favStarFill.png'
                        : 'assets/images/favStar.png',
                    onToggleFav: () {
                      // 즐겨찾기 상태를 토글하는 로직
                    },
                  );
                },
              ),
      );
  }
}

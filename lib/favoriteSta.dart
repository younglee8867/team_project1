// 즐겨찾기 화면
import 'package:flutter/material.dart';
import './util/util.dart';
import 'package:provider/provider.dart';
import './widgets//searchResultItem.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoriteSta extends StatelessWidget {
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
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<SearchHistoryProvider>(
        builder: (context, provider, child) {
          // 즐겨찾기된 항목만 필터링
          final favList = provider.searchHistory
              .where((item) => item['isFavorite'] == true)
              .toList();

          if (favList.isEmpty) {
            // 즐겨찾기가 없을 때
            return Center(
              child: Text(
                '즐겨찾기 항목이 없습니다.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ).tr(),
            );
          } else {
            // 즐겨찾기 리스트 출력
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final record = favList[index];
                return SearchResultItem(
                  stationName: record['name'],
                  favImagePath: 'assets/images/favStarFill.png',
                  onToggleFav: () => provider.toggleFavorite(
                    provider.searchHistory.indexOf(record),
                  ), // 원래 리스트의 인덱스를 전달
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../widgets/searchResultItem.dart';
import '../util/util.dart';

class WriteStationPage extends StatelessWidget {
  final TextEditingController _startStationController = TextEditingController();
  final TextEditingController _endStationController = TextEditingController();

  // 출발역과 도착역 교환
  void _swapStations() {
    String temp = _startStationController.text;
    _startStationController.text = _endStationController.text;
    _endStationController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, {
              'startStation': _startStationController.text,
              'endStation': _endStationController.text,
            });
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '경로검색',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 출발역 및 도착역 입력바
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_vert, color: Colors.black),
                  onPressed: _swapStations,
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _startStationController,
                        decoration: InputDecoration(
                          hintText: '출발역 입력'.tr(),
                          hintStyle: TextStyle(color: Color(0xFFABABAB)),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xff386B88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            searchHistoryProvider.addSearchHistory(value);
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _endStationController,
                        decoration: InputDecoration(
                          hintText: '도착역 입력'.tr(),
                          hintStyle: TextStyle(color: Color(0xFFABABAB)),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xff386B88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            searchHistoryProvider.addSearchHistory(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 검색기록
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistoryProvider.searchHistory.length,
                itemBuilder: (context, index) {
                  final record = searchHistoryProvider.searchHistory[index];
                  return SearchResultItem(
                    stationName: record['name'],
                    favImagePath: record['isFavorite']
                        ? 'assets/images/favStarFill.png'
                        : 'assets/images/favStar.png',
                    onToggleFav: () => searchHistoryProvider.toggleFavorite(index),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: searchHistoryProvider.clearHistory,
              child: Text('검색기록 삭제').tr(),
            ),
          ],
        ),
      ),
    );
  }
}

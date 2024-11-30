// 길찾기 화면(출발역,도착역 검색)
//11.29 SharedStationData 사용

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/searchResultItem.dart';
import '../favoriteSta.dart';
import '../util/util.dart';

class WriteStationPage extends StatefulWidget {
  final String? initialStartStation;
  final String? initialEndStation;
  final List<Map<String, dynamic>> searchHistory; // 검색 기록 전달받기

  WriteStationPage({
    this.initialStartStation,
    this.initialEndStation,
    required this.searchHistory,
  });

  @override
  _WriteStationPageState createState() => _WriteStationPageState();
}

class _WriteStationPageState extends State<WriteStationPage> {
  final TextEditingController _startStationController = TextEditingController();
  final TextEditingController _endStationController = TextEditingController();

  late List<Map<String, dynamic>> _searchHistory;

  @override
  void initState() {
    super.initState();
    // 초기 값 설정
    _searchHistory = SharedStationData.searchHistory; // SharedStationData 사용
    if (widget.initialStartStation != null) {
      _startStationController.text = widget.initialStartStation!;
    }
    if (widget.initialEndStation != null) {
      _endStationController.text = widget.initialEndStation!;
    }
  }

  void _addSearchRecord(String stationName) {
    setState(() {
      SharedStationData.addSearchHistory({
        "name": stationName,
        "isFavorite": false,
      }); // 검색 기록 추가
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      SharedStationData.toggleFavoriteStatus(_searchHistory[index]['name']);
    });
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  // 출발역과 도착역 교환
  void _swapStations() {
    setState(() {
      String temp = _startStationController.text;
      _startStationController.text = _endStationController.text;
      _endStationController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // 검색 기록과 입력 값을 반환
            Navigator.pop(context, {
              'startStation': _startStationController.text,
              'endStation': _endStationController.text,
              'searchHistory': _searchHistory,
            });
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '길찾기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        //padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 출발역 및 도착역 입력바
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_vert, color: Color(0xff386B88)),
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
                          if (value.isNotEmpty) _addSearchRecord(value);
                        },
                        onChanged: (value) {
                          // 사용자가 입력할 때 자동으로 '역' 추가 -> 번역 안돼서 그냥 없앰
                          if (value.length >= 3) {
                            //final translatedSuffix = '역'.tr();
                            _startStationController.value = TextEditingValue(
                              text: "$value ",
                            );
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
                          if (value.isNotEmpty) _addSearchRecord(value);
                        },
                        onChanged: (value) {
                          if (value.length >= 3) {
                            //String translatedSuffix = '역'.tr();
                            _endStationController.value = TextEditingValue(
                              text: "$value ",
                            );
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
            Flexible(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  final record = _searchHistory[index];
                  return SearchResultItem(
                    stationName: record['name'] + "역".tr(),
                    favImagePath: record['isFavorite']
                        ? 'assets/images/favStarFill.png'
                        : 'assets/images/favStar.png', // 상태에 따라 이미지 선택
                    onToggleFav: () => _toggleFavorite(index), // 인덱스를 전달
                    onSelect: () {
                      setState(() {
                        // 기록에 있는 역을 검색창으로
                        // 현재 입력 포커스를 확인
                        if (_startStationController.selection.baseOffset !=
                            -1) {
                          // 출발역에 포커스가 있는 경우
                          _startStationController.text = record['name'];
                        } else if (_endStationController.selection.baseOffset !=
                            -1) {
                          // 도착역에 포커스가 있는 경우
                          _endStationController.text = record['name'];
                        } else {
                          // 기본적으로 출발역에 입력
                          _startStationController.text = record['name'];
                        }
                      });
                    },
                  );
                },
              ),
            ),
            TextButton(
              onPressed: _clearSearchHistory,
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFACACAC), // 텍스트 색상
              ),
              child: Text('검색기록 삭제').tr(),
            ),
          ],
        ),
      ),
    );
  }
}

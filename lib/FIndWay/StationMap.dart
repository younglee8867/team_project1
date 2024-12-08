// 길찾기 화면(노선도)
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/main.dart';

import '../util/util.dart';
import 'WriteStation.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StationMap(),
    );
  }
}

class StationMap extends StatefulWidget {
  @override
  _StationMapState createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  String _startStation = ''; // 출발역
  String _endStation = ''; // 도착역
  List<Map<String, dynamic>> _searchHistory = []; // 검색 기록 리스트
  String? _selectedLine = '전체'; // 드롭다운의 초기 선택값 설정
  String _currentMapPath = 'assets/images/station/StationMap.jpg'; // 초기 노선도 경로
  String _currentMapPathTodark = 'assets/images/station/stationMap_dark_.jpg';
  // 출발역과 도착역을 교환하는 메서드
  void _swapStations() {
    setState(() {
      final temp = _startStation;
      _startStation = _endStation;
      _endStation = temp;
    });
  }

  void _addToSearchHistory(String station) {
    setState(() {
      _searchHistory.add({'station': station, 'timestamp': DateTime.now()});
    });
  }

  // 역 검색 페이지로 이동하는 메서드
  Future<void> _navigateToSearch(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteStationPage(
          initialStartStation: _startStation,
          initialEndStation: _endStation,
          searchHistory: _searchHistory, // 검색 기록 전달
        ),
        settings: RouteSettings(name: '/writeStation'), // 라우트 이름 설정
      ),
    );

// WriteStation에서 돌아오면 출발역, 도착역, 검색 기록 값을 업데이트
    if (result != null) {
      setState(() {
        if (result['startStation'] != null) {
          _startStation = result['startStation'];
        }
        if (result['endStation'] != null) {
          _endStation = result['endStation'];
        }
        if (result['searchHistory'] != null) {
          _searchHistory = result['searchHistory'];
        }
      });
    }
  }

  // 드롭박스 값 변경 시 노선도 업데이트
  void _updateMap(String line) {
  final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
  final stationMap = themeNotifier.isDarkMode ? getStationMapDark() : getStationMapLight();

  setState(() {
    _currentMapPath = stationMap[line] ??
        (themeNotifier.isDarkMode
            ? 'assets/images/station/StationMap_dark.jpg'
            : 'assets/images/station/StationMap.jpg');
    _selectedLine = line;

  });
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
          child:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '길찾기',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_vert, color: Color(0xff386B88)),
                  onPressed: _swapStations, // 교환 메서드 호출
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: TextEditingController(text: _startStation),
                        decoration: InputDecoration(
                            hintText: '출발역 입력'.tr(),
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Color(0xff386B88),
                            fillColor: themeNotifier.isDarkMode
                                ? const Color.fromARGB(179, 211, 211, 211)
                                : Colors.white, // 배경색 설정
                            filled: true, // 배경색 활성화
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              //borderSide: BorderSide(color: Color.fromRGBO(0, 57, 115, 148) )
                            ),
                            hintStyle: TextStyle(
                              color: themeNotifier.isDarkMode
                                  ? const Color.fromARGB(255, 27, 27, 27)
                                  : Color(0xFFABABAB),
                            )),
                        onTap: () => _navigateToSearch(context),
                        readOnly: true, // 클릭 시에만 검색 페이지로 이동
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(text: _endStation),
                        decoration: InputDecoration(
                            hintText: '도착역 입력'.tr(),
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Color(0xff386B88),
                            fillColor: themeNotifier.isDarkMode
                                ? const Color.fromARGB(179, 211, 211, 211)
                                : Colors.white, // 배경색 설정
                            filled: true, // 배경색 활성화
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintStyle: TextStyle(
                              color: themeNotifier.isDarkMode
                                  ? const Color.fromARGB(255, 27, 27, 27)
                                  : Color(0xFFABABAB),
                            )),
                        onTap: () => _navigateToSearch(context),
                        readOnly: true, // 클릭 시에만 검색 페이지로 이동
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  // 노선도 이미지
                  InteractiveViewer(
                    boundaryMargin: EdgeInsets.all(20.0),
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Container(
                      child: Center(
                        child: Image.asset(
                        _currentMapPath ?? (
                          themeNotifier.isDarkMode
                                ? _currentMapPathTodark
                                : _currentMapPath),
                        ),
                      ),
                    ),
                  ),
                  // 호선별 드롭박스
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xff397394),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedLine,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.white, size: 18),
                        dropdownColor: themeNotifier.isDarkMode
                            ? Color.fromARGB(255, 68, 97, 113)
                            : Color.fromARGB(255, 128, 180, 210),
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _updateMap(newValue);
                          }
                        },
                        items: <String>[
                          '전체',
                          '1호선',
                          '2호선',
                          '3호선',
                          '4호선',
                          '5호선',
                          '6호선',
                          '7호선',
                          '8호선',
                          '9호선'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

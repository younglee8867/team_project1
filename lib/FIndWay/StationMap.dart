// 길찾기 화면(노선도)
import 'package:flutter/material.dart';
import 'WriteStation.dart'; // WriteStation 페이지를 import
import 'package:easy_localization/easy_localization.dart';

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
// 검색바 색깔 const Color.fromRGBO(0, 57, 115, 148)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff22536F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            //borderSide: BorderSide(color: Color.fromRGBO(0, 57, 115, 148) )
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFABABAB),
                          ) 
                        ),
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFABABAB)
                          )
                        ),
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
                        child: Image.asset('assets/images/StationMap.png'),
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
                        dropdownColor: Color.fromARGB(255, 128, 180, 210),
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLine = newValue;
                          });
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../util/util.dart'; // SearchHistoryProvider 정의된 파일
import 'WriteStation.dart'; // WriteStation 페이지를 import

class StationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);

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
            // 출발역 및 도착역 입력
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_vert, color: Color(0xff386B88)),
                  onPressed: searchHistoryProvider.swapStations,
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: '출발역 입력'.tr(),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xff386B88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFABABAB),
                          ),
                        ),
                        onTap: () async {
                          await _navigateToSearch(context, searchHistoryProvider);
                        },
                        readOnly: true,
                        controller: TextEditingController(
                          text: searchHistoryProvider.startStation,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '도착역 입력'.tr(),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xff386B88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFFABABAB),
                          ),
                        ),
                        onTap: () async {
                          await _navigateToSearch(context, searchHistoryProvider);
                        },
                        readOnly: true,
                        controller: TextEditingController(
                          text: searchHistoryProvider.endStation,
                        ),
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
                    child: Center(
                      child: Image.asset('assets/images/StationMap.jpg'),
                    ),
                  ),
                  // 호선별 드롭다운
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xff397394),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String>(
                        value: searchHistoryProvider.selectedLine,
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.white, size: 18),
                        dropdownColor: Color.fromARGB(255, 128, 180, 210),
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          searchHistoryProvider.setSelectedLine(newValue ?? '전체');
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

  Future<void> _navigateToSearch(
      BuildContext context, SearchHistoryProvider provider) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteStationPage(),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      if (result.containsKey('startStation')) {
        provider.setStartStation(result['startStation']);
      }
      if (result.containsKey('endStation')) {
        provider.setEndStation(result['endStation']);
      }
    }
  }
}

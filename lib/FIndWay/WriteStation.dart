import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/FIndWay/minimumDistance.dart';
import 'package:flutter_application_1/main.dart';
//import 'package:flutter_application_1/FindWay/minimumDistance.dart';

import '../widgets/searchResultItem.dart';
import '../favoriteSta.dart';
import '../util/util.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

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
    _searchHistory = SharedStationData.searchHistory;
    if (widget.initialStartStation != null) {
      _startStationController.text = widget.initialStartStation!;
    }
    if (widget.initialEndStation != null) {
      _endStationController.text = widget.initialEndStation!;
    }
  }

  // 출발역 도착역 입력시 유효성 검사
  void _navigateToMinimumDistance() {
    String startStation = _startStationController.text.trim();
    String endStation = _endStationController.text.trim();

    // 1. 빈 입력값 확인
    if (startStation.isEmpty || endStation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('출발역과 도착역을 모두 입력하세요.')),
      );
      return;
    }

    // 2. 동일 역 입력 확인
    if (startStation == endStation) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('출발역과 도착역은 서로 달라야 합니다.')),
      );
      return;
    }

    // 3. 숫자인지 확인
    final startNumber = int.tryParse(startStation);
    final endNumber = int.tryParse(endStation);

    if (startNumber == null || endNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('숫자만 입력해주세요.')),
      );
      return;
    }

    // 4. 세 자리인지 확인
    if (startStation.length != 3 || endStation.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('숫자 세 자리를 입력해주세요.')),
      );
      return;
    }

    // 5. 유효한 역 번호인지 확인
    if (!_isStationInRange(startNumber) || !_isStationInRange(endNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('입력된 역 번호가 유효하지 않습니다.')),
      );
      return;
    }

    // 모든 조건을 통과한 경우 페이지 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => minimumDistance(
          startStation: startStation,
          endStation: endStation,
        ),
      ),
    );
  }

// 유효한 역 번호인지 확인하는 함수
  bool _isStationInRange(int number) {
    return (101 <= number && number <= 123) ||
        (201 <= number && number <= 217) ||
        (301 <= number && number <= 308) ||
        (401 <= number && number <= 417) ||
        (501 <= number && number <= 507) ||
        (601 <= number && number <= 622) ||
        (701 <= number && number <= 707) ||
        (801 <= number && number <= 806) ||
        (901 <= number && number <= 904);
  }

  void _addSearchRecord(String stationName) {
    setState(() {
      SharedStationData.addSearchHistory({
        "name": stationName,
        "isFavorite": false,
      });
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

  void _swapStations() {
    setState(() {
      String temp = _startStationController.text;
      _startStationController.text = _endStationController.text;
      _endStationController.text = temp;
    });
  }

  // 공통된 함수로 빼기
  Widget buildStationInputField(TextEditingController controller, String hint,
      Function(String) onSubmitted) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint.tr(),
        hintStyle: TextStyle(
            color: themeNotifier.isDarkMode
                ? const Color.fromARGB(255, 27, 27, 27)
                : Color(0xFFABABAB)),
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Color(0xff386B88),
        fillColor: themeNotifier.isDarkMode
            ? const Color.fromARGB(179, 211, 211, 211)
            : Colors.white, // 배경색 설정
        filled: true, // 배경색 활성화
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onSubmitted: (value) {
        // 사용자가 Enter를 누르면 페이지 전환 검사 실행
        onSubmitted(value);
        _navigateToMinimumDistance(); // 입력값 확인 후 페이지 전환
      },
    );
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
                Container(
                  alignment: Alignment.center, // 컨테이너 내부에서 가운데 정렬
                  child: IconButton(
                    icon: Icon(Icons.swap_vert, color: Color(0xff386B88)),
                    onPressed: _swapStations,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // 출발역 입력 필드
                      buildStationInputField(
                        _startStationController,
                        '출발역 입력',
                        (value) {
                          if (value.isNotEmpty) {
                            if (value.length == 3) {
                              final number = int.tryParse(value) ?? 0;
                              if ((101 <= number && number <= 123) ||
                                  (201 <= number && number <= 217) ||
                                  (301 <= number && number <= 308) ||
                                  (401 <= number && number <= 417) ||
                                  (501 <= number && number <= 507) ||
                                  (601 <= number && number <= 622) ||
                                  (701 <= number && number <= 707) ||
                                  (801 <= number && number <= 806) ||
                                  (901 <= number && number <= 904)) {
                                _addSearchRecord(value);
                                _startStationController.value =
                                    TextEditingValue(
                                  text: "$value",
                                );
                              } else {
                                _startStationController.clear();
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("오류"),
                                    content: Text("유효하지 않은 역 번호입니다."),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("확인"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("오류"),
                                  content: Text("숫자 세 자리를 입력해주세요."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("확인"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      // 도착역 입력 필드
                      buildStationInputField(
                        _endStationController,
                        '도착역 입력',
                        (value) {
                          if (value.isNotEmpty) {
                            if (value.length == 3) {
                              final number = int.tryParse(value) ?? 0;
                              if ((101 <= number && number <= 123) ||
                                  (201 <= number && number <= 217) ||
                                  (301 <= number && number <= 308) ||
                                  (401 <= number && number <= 417) ||
                                  (501 <= number && number <= 507) ||
                                  (601 <= number && number <= 622) ||
                                  (701 <= number && number <= 707) ||
                                  (801 <= number && number <= 806) ||
                                  (901 <= number && number <= 904)) {
                                _addSearchRecord(value);
                                _endStationController.value = TextEditingValue(
                                  text: "$value",
                                );
                              } else {
                                _endStationController.clear();
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("오류"),
                                    content: Text("유효하지 않은 역 번호입니다."),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("확인"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("오류"),
                                  content: Text("숫자 세 자리를 입력해주세요."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("확인"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      ),
                      TextButton(
                        onPressed: _clearSearchHistory,
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFFACACAC),
                        ),
                        child: Text('검색기록 삭제').tr(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  final record = _searchHistory[index];
                  return GestureDetector(
                    onTap: () {
                      // 항목 클릭 시 검색 필드에 값 설정
                      setState(() {
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
                    child: SearchResultItem(
                      stationName: record['name'] + " " + "역".tr(),
                      favImagePath: record['isFavorite']
                          ? 'assets/images/favStarFill.png'
                          : 'assets/images/favStar.png',
                      onToggleFav: () => _toggleFavorite(index),
                      onSelect: () {
                        // 텍스트 클릭 시 동작
                        setState(() {
                          if (_startStationController.selection.baseOffset !=
                              -1) {
                            // 출발역에 포커스가 있는 경우
                            _startStationController.text = record['name'];
                          } else if (_endStationController
                                  .selection.baseOffset !=
                              -1) {
                            // 도착역에 포커스가 있는 경우
                            _endStationController.text = record['name'];
                          } else {
                            // 기본적으로 출발역에 입력
                            _startStationController.text = record['name'];
                          }
                        });
                      },
                    ),
                  );
                },
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

import 'package:flutter/material.dart';

class WriteStationPage extends StatefulWidget {
  final String? initialStartStation;
  final String? initialEndStation;
  final List<Map<String, dynamic>> searchHistory; // 검색 기록 전달받기

  WriteStationPage({
    this.initialStartStation,
    this.initialEndStation,
    required this.searchHistory,
  });

<<<<<<< HEAD
class MyApp extends StatelessWidget {
  const MyApp({super.key});

=======
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
  @override
  _WriteStationPageState createState() => _WriteStationPageState();
}

<<<<<<< HEAD
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _searchHistory = [];
=======
class _WriteStationPageState extends State<WriteStationPage> {
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
  final TextEditingController _startStationController = TextEditingController();
  final TextEditingController _endStationController = TextEditingController();

  late List<Map<String, dynamic>> _searchHistory;

  @override
  void initState() {
    super.initState();
    // 초기 값 설정
    _searchHistory = List.from(widget.searchHistory);
    if (widget.initialStartStation != null) {
      _startStationController.text = widget.initialStartStation!;
    }
    if (widget.initialEndStation != null) {
      _endStationController.text = widget.initialEndStation!;
    }
  }

  void _addSearchRecord(String stationName) {
    setState(() {
      // 중복된 기록 제거 후 추가
      _searchHistory.removeWhere((record) => record['name'] == stationName);
      _searchHistory.insert(0, {'name': stationName, 'isFavorite': false});
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _searchHistory[index]['isFavorite'] =
          !_searchHistory[index]['isFavorite'];
    });
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("역 검색"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // 검색 기록과 입력 값을 반환
            Navigator.pop(context, {
              'startStation': _startStationController.text,
              'endStation': _endStationController.text,
              'searchHistory': _searchHistory,
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
<<<<<<< HEAD
            const SizedBox(height: 40), // 상단 여백 추가
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20), // 검색창과 뒤로 가기 버튼 사이의 여백 추가
=======
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
<<<<<<< HEAD
                  icon: const Icon(Icons.swap_vert, color: Colors.black),
                  onPressed: () {},
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _startStationController,
                        decoration: InputDecoration(
                          hintText: '출발역 입력',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) _addSearchRecord(value);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _endStationController,
                        decoration: InputDecoration(
                          hintText: '도착역 입력',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) _addSearchRecord(value);
                        },
                      ),
                    ],
=======
                  icon: Icon(Icons.swap_vert, color: Colors.black),
                  onPressed: () {
                    String temp = _startStationController.text;
                    _startStationController.text = _endStationController.text;
                    _endStationController.text = temp;
                  },
                ),
                Expanded(
                    child: Column(children: [
                  TextField(
                    controller: _startStationController,
                    decoration: InputDecoration(
                      hintText: '출발역 입력',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) _addSearchRecord(value);
                    },
>>>>>>> a4684a8f3fd9a29f61913b92486060a6e1e3ae56
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _endStationController,
                    decoration: InputDecoration(
                      hintText: '도착역 입력',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) _addSearchRecord(value);
                    },
                  ),
                ])),
              ],
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  final record = _searchHistory[index];
                  return ListTile(
                    leading: const Icon(Icons.train),
                    title: Text(record['name']),
                    trailing: IconButton(
                      icon: Icon(
                        record['isFavorite'] ? Icons.star : Icons.star_border,
                        color:
                            record['isFavorite'] ? Colors.amber : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(index),
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: _clearSearchHistory,
              child: const Text('검색기록 삭제'),
            ),
          ],
        ),
      ),
    );
  }
}

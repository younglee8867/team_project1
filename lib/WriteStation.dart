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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
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

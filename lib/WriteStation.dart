import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _searchHistory = [];
  final TextEditingController _startStationController = TextEditingController();
  final TextEditingController _endStationController = TextEditingController();

  void _addSearchRecord(String stationName) {
    setState(() {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40), // 상단 여백 추가
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20), // 검색창과 뒤로 가기 버튼 사이의 여백 추가
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_vert, color: Colors.black),
                  onPressed: () {},
                ),
                Expanded(
                  child: Column(
                    children: [
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
                  return ListTile(
                    leading: Icon(Icons.train),
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
              child: Text('검색기록 삭제'),
            ),
          ],
        ),
      ),
    );
  }
}

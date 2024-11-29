import 'package:flutter/foundation.dart';

class SearchHistoryProvider extends ChangeNotifier {
  // 검색 기록 리스트
  List<Map<String, dynamic>> _searchHistory = [];
  // 출발역과 도착역
  String _startStation = '';
  String _endStation = '';
  // 호선 선택
  String _selectedLine = '전체';
  // 메뉴 표시 상태
  bool _isMenuVisible = false;
  
  // 검색 기록 Getter
  List<Map<String, dynamic>> get searchHistory => _searchHistory;

  // getter: 메뉴 표시 여부 가져오기
  bool get isMenuVisible => _isMenuVisible;

  // 출발역 Getter와 Setter
  String get startStation => _startStation;
  void setStartStation(String station) {
    _startStation = station;
    notifyListeners();
  }

  // 도착역 Getter와 Setter
  String get endStation => _endStation;
  void setEndStation(String station) {
    _endStation = station;
    notifyListeners();
  }

  // 호선 선택 Getter와 Setter
  String get selectedLine => _selectedLine;
  void setSelectedLine(String line) {
    _selectedLine = line;
    notifyListeners();
  }

  /// 메뉴 표시/숨기기 토글
  void toggleMenuVisibility() {
    _isMenuVisible = !_isMenuVisible;
    notifyListeners();
  }


  // 출발역과 도착역 교환
  void swapStations() {
    final temp = _startStation;
    _startStation = _endStation;
    _endStation = temp;
    notifyListeners();
  }

  // 검색 기록 추가
  void addSearchHistory(String stationName) {
    if (!_searchHistory.any((item) => item['name'] == stationName)) {
      _searchHistory.insert(0, {'name': stationName, 'isFavorite': false});
      notifyListeners();
    }
  }

  // 검색 기록 삭제
  void clearHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  // 즐겨찾기 토글
  void toggleFavorite(int index) {
    if (index >= 0 && index < _searchHistory.length) {
      _searchHistory[index]['isFavorite'] = !_searchHistory[index]['isFavorite'];
      notifyListeners();
    }
  }
}

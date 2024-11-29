// 공통 로직 또는 유틸리티 함수
//11.29 SharedStationData로 길찾기페이지와 역검색페이지에서
// 통합적으로 관리하도록 했습니다..

class SharedStationData {
  static List<Map<String, dynamic>> searchHistory = [];
  static List<Map<String, dynamic>> favoriteStations = [];

  // 검색 기록 추가
  //앱 전체에서 공유되는 검색기록을 관리
  //모든 화면에서 공통적으로 참조되는 검색기록
  static void addSearchHistory(Map<String, dynamic> station) {
    if (!searchHistory.any((item) => item['name'] == station['name'])) {
      searchHistory.add(station);
    }
  }

  // 즐겨찾기 상태
  static void toggleFavoriteStatus(String stationName) {
    for (var station in searchHistory) {
      if (station['name'] == stationName) {
        station['isFavorite'] = !(station['isFavorite'] ?? false);
        break;
      }
    }
    // 즐겨찾기 목록 업데이트
    favoriteStations = searchHistory
        .where((station) => station['isFavorite'] == true)
        .toList();
  }
}

// 검색 기록 추가
bool addSearchHistory(List<Map<String, dynamic>> history, String stationName) {
  if (!history.any((item) => item['name'] == stationName)) {
    history.insert(0, {'name': stationName, 'isFavorite': false});
    return true;
  }
  return false;
}

// 검색기록 삭제
void clearHistory(List history) {
  history.clear();
}

// 즐겨찾기 표시
void toggleFavorite(List<Map<String, dynamic>> history, int index) {
  if (index >= 0 && index < history.length) {
    history[index]['isFavorite'] = !history[index]['isFavorite'];
  }
}

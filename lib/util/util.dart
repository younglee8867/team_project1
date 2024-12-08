// 공통 로직 또는 유틸리티 함수

class SharedStationData {
  static List<Map<String, dynamic>> searchHistory = [];
  static List<Map<String, dynamic>> favoriteStations = [];

  // 검색 기록 추가
  //앱 전체에서 공유되는 검색기록을 관리
  //모든 화면에서 공통적으로 참조되는 검색기록
  static void addSearchHistory(Map<String, dynamic> station) {
    // 기존 검색 기록에서 해당 역 찾기
    final existingStation = searchHistory.firstWhere(
      (item) => item['name'] == station['name'],
      orElse: () => <String, dynamic>{}, // 빈 맵 반환
    );

    // 기존 즐겨찾기 상태 유지
    if (existingStation.isNotEmpty) {
      station['isFavorite'] = existingStation['isFavorite'];
      searchHistory.remove(existingStation); // 기존 항목 삭제
    }

    // 새 검색 기록 추가
    searchHistory.insert(0, station);
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

Map<String, String> getStationMapLight() {
  return {
    '전체': 'assets/images/station/StationMap.jpg',
    '1호선': 'assets/images/station/Line1.jpg',
    '2호선': 'assets/images/station/Line2.jpg',
    '3호선': 'assets/images/station/Line3.jpg',
    '4호선': 'assets/images/station/Line4.jpg',
    '5호선': 'assets/images/station/Line5.jpg',
    '6호선': 'assets/images/station/Line6.jpg',
    '7호선': 'assets/images/station/Line7.jpg',
    '8호선': 'assets/images/station/Line8.jpg',
    '9호선': 'assets/images/station/Line9.jpg',
  };
}

Map<String, String> getStationMapDark() {
  return {
    '전체': 'assets/images/station/stationMap_dark_.jpg',
    '1호선': 'assets/images/station/Line1_dark_.jpg',
    '2호선': 'assets/images/station/Line2_dark_.jpg',
    '3호선': 'assets/images/station/Line3_dark_.jpg',
    '4호선': 'assets/images/station/Line4_dark_.jpg',
    '5호선': 'assets/images/station/Line5_dark_.jpg',
    '6호선': 'assets/images/station/Line6_dark_.jpg',
    '7호선': 'assets/images/station/Line7_dark_.jpg',
    '8호선': 'assets/images/station/Line8_dark_.jpg',
    '9호선': 'assets/images/station/Line9_dark_.jpg',
  };
}
/* Map<String, Map<String, String>> getStationMap() {
  return {
    '전체': {
      'light': 'assets/images/station/StationMap.jpg',
      'dark': 'assets/images/station/stationMap_dark_.jpg',
    },
    '1호선': {
      'light': 'assets/images/station/Line1.jpg',
      'dark': 'assets/images/station/Line1_dark_.jpg',
    },
    '2호선': {
      'light': 'assets/images/station/Line2.jpg',
      'dark': 'assets/images/station/Line2_dark+.jpg',
    },
    '3호선': {
      'light': 'assets/images/station/Line3.jpg',
      'dark': 'assets/images/station/Line3_dark_.jpg',
    },
    '4호선': {
      'light': 'assets/images/station/Line4.jpg',
      'dark': 'assets/images/station/Line4_dark_.jpg',
    },
    '5호선': {
      'light': 'assets/images/station/Line5.jpg',
      'dark': 'assets/images/station/Line5_dark_.jpg',
    },
    '6호선': {
      'light': 'assets/images/station/Line6.jpg',
      'dark': 'assets/images/station/Line6_dark_.jpg',
    },
    '7호선': {
      'light': 'assets/images/station/Line7.jpg',
      'dark': 'assets/images/station/Line7_dark_.jpg',
    },
    '8호선': {
      'light': 'assets/images/station/Line8.jpg',
      'dark': 'assets/images/station/Line8_dark_.jpg',
    },
    '9호선': {
      'light': 'assets/images/station/Line9.jpg',
      'dark': 'assets/images/station/Line9_dark_.jpg',
    },
  };
} */

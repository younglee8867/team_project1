// 재사용 할 수 있는 함수는 여기에 정의해서 같이 씁시다.~
// 나영님이랑 검색기록 저장하는 함수가 비슷한 거 같아서 여기다가 같이 써요>~>>~>~>

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
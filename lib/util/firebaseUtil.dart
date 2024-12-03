import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> fetchStationData(String stationName) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('station').doc(stationName).get();
    if (doc.exists) {
      return doc.data();
    } else {
      print("역 정보가 없습니다.");
      return null;
    }
  } catch (e) {
    if (e is FirebaseException) {
      // FirebaseException일 경우 처리
      print("Firebase 오류 발생: ${e.message}");
    } else {
      // 다른 유형의 오류 처리
      print("데이터를 가져오는 중 오류 발생: $e");
    }
    return null;
  }
}





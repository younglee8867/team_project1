import 'package:cloud_firestore/cloud_firestore.dart';
Future<String?> _getPreviousStation(String currentStation) async {
  final collection = FirebaseFirestore.instance.collection('station');

  // 현재 역의 station_id 가져오기
  final currentStationSnapshot = await collection
      .where('station_name', isEqualTo: currentStation)
      .limit(1)
      .get();

  if (currentStationSnapshot.docs.isEmpty) {
    return null; // 해당 역을 찾을 수 없음
  }

  final currentStationId = currentStationSnapshot.docs.first['station_id'] as int;

  // 이전 역 가져오기
  final previousStationSnapshot = await collection
      .where('station_id', isEqualTo: currentStationId - 1)
      .limit(1)
      .get();

  if (previousStationSnapshot.docs.isNotEmpty) {
    return previousStationSnapshot.docs.first['station_name'] as String;
  }

  return null; // 이전 역이 없는 경우
}
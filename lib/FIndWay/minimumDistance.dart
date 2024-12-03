// 최소거리 화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/firebaseUtil.dart';

class minimumDistance extends StatefulWidget {
  final String startStation;
  final String endStation;

  const minimumDistance({
    Key? key,
    required this.startStation,
    required this.endStation,
  }) : super(key: key);

  @override
  _minimumDistanceState createState() => _minimumDistanceState();
}

class _minimumDistanceState extends State<minimumDistance> {
  late Future<Map<String, dynamic>?> startStationData;
  late Future<Map<String, dynamic>?> endStationData;
  late Map<String, List<Map<String, dynamic>>> graph;

  @override
  void initState() {
    super.initState();
    startStationData = fetchStationData(widget.startStation);
    endStationData = fetchStationData(widget.endStation);
    graph = {};
  }

  Future<void> buildGraph() async {
    try {
      final stationsSnapshot =
          await FirebaseFirestore.instance.collection('station').get();
      for (var doc in stationsSnapshot.docs) {
        final data = doc.data();
        if (data.containsKey('routeInfo')) {
          final routeInfo = data['routeInfo'];
          String startStation = routeInfo['startStation'].toString();
          String endStation = routeInfo['endStation'].toString();
          int distance = routeInfo['distance'];

          graph.putIfAbsent(startStation, () => []);
          graph[startStation]!
              .add({'station': endStation, 'distance': distance});
        }
      }
      print("그래프 생성 완료: $graph");
    } catch (e) {
      print("그래프를 생성하는 동안 오류 발생: $e");
    }
  }

  int dfs(String currentStation, String endStation, Set<String> visited,
      int currentDistance) {
    if (!graph.containsKey(currentStation) || !graph.containsKey(endStation)) {
      print("경로 없음: 출발역 $currentStation 또는 도착역 $endStation 이 그래프에 존재하지 않음.");
      return -1;
    }

    if (currentStation == endStation) {
      print(
          "도착: currentStation=$currentStation, totalDistance=$currentDistance");
      return currentDistance;
    }

    visited.add(currentStation);
    print("현재 방문 노드: $visited");

    if (graph[currentStation] == null || graph[currentStation]!.isEmpty) {
      print("currentStation=$currentStation 에 연결된 이웃 노드가 없습니다.");
      return -1; // 이웃 노드가 없으면 경로를 찾을 수 없음
    }

/*     // 현재 역에서 도착역으로 바로 연결된 경로가 있는지 확인
    for (var neighbor in graph[currentStation] ?? []) {
      String nextStation = neighbor['station'];
      int distanceToNext = neighbor['distance'];

      if (nextStation == endStation) {
        print(
            "직접 경로 발견: $currentStation -> $endStation, distance=$distanceToNext");
        return currentDistance + distanceToNext; // 바로 반환
      }
    }
 */
    double minDistance = double.infinity;

    for (var neighbor in graph[currentStation] ?? []) {
      String nextStation = neighbor['station'];
      int distanceToNext = neighbor['distance'];

      print("이웃 탐색: nextStation=$nextStation, distanceToNext=$distanceToNext");

      if (nextStation == endStation) {
        print(
            "직접 경로 발견: $currentStation -> $endStation, distance=$distanceToNext");
        return currentDistance; // 바로 반환
      }

      if (!visited.contains(nextStation)) {
        int distance = dfs(
            nextStation, endStation, visited, currentDistance + distanceToNext);
        if (distance < minDistance) {
          minDistance = distance.toDouble();
        }
      }
    }

    visited.remove(currentStation);

    print("백트래킹: currentStation=$currentStation, visited=$visited");

    return minDistance == double.infinity ? -1 : minDistance.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
              }
            },
            child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
          ),
          title: Text(
            '길찾기',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff22536F),
            ),
          ).tr(),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: Future.wait([startStationData, endStationData, buildGraph()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
            } else if (!snapshot.hasData || snapshot.data![2] == false) {
              return Center(
                child: Text("출발역 또는 도착역 정보를 찾을 수 없습니다."),
              );
            }

            final startData = snapshot.data![0];
            final endData = snapshot.data![1];
            print("!!!!!!!!startStationData: $startData");
            print("!!!!!!!!endStationData: $endData");

            int minDistance = dfs(startData['routeInfo']['startStation'],
                endData['routeInfo']['endStation'], {}, 0);
            print("DFS 결과: 최소 거리 = $minDistance");

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text("출발역: ${widget.startStation}"),
                Text("도착역: ${widget.endStation}"),
                _buildTravelDetails(minDistance),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircleWithText(String stationName) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          stationName,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildStationInfo(Map<String, dynamic>? data) {
    return data == null
        ? Text("역 정보를 가져올 수 없습니다.")
        : Text(
            "역 정보: ${data['stationDetails']['quickExit']}",
            style: TextStyle(fontSize: 16),
          );
  }

  Widget _buildTravelDetails(int distance) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        distance == -1 ? "출발역에서 도착역으로 가는 경로를 찾을 수 없습니다." : "최소 거리: $distance m",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

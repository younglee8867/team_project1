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
          int duration = routeInfo['duration'];
          int cost = routeInfo['cost'];

          // 단방향 경로 추가 (start -> end)
          graph.putIfAbsent(startStation, () => []);
          graph[startStation]!.add({
            'station': endStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });

          // 역방향 경로 추가 (end -> start)
          graph.putIfAbsent(endStation, () => []);
          graph[endStation]!.add({
            'station': startStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });

          print("그래프에 추가: $startStation <-> $endStation ($distance m)");
        }
      }
      print("그래프 생성 완료: $graph");
    } catch (e) {
      print("그래프를 생성하는 동안 오류 발생: $e");
    }
  }

  Map<String, dynamic> dijkstra(String startStation, String endStation) {
    if (!graph.containsKey(startStation) || !graph.containsKey(endStation)) {
      print("경로 없음: 출발역 $startStation 또는 도착역 $endStation 이 그래프에 존재하지 않음.");
      return {};
    }

    // 거리, 소요 시간, 비용 배열 초기화
    Map<String, double> distances = {};
    Map<String, double> durations = {};
    Map<String, double> costs = {};
    Map<String, String?> previousNodes = {};
    Set<String> visited = {};

    // 모든 노드 초기화
    for (var station in graph.keys) {
      distances[station] = double.infinity; // 무한대
      durations[station] = double.infinity; // 무한대
      costs[station] = double.infinity; // 무한대
      previousNodes[station] = null;
    }

    // 시작 노드 초기화
    distances[startStation] = 0;
    durations[startStation] = 0;
    costs[startStation] = 0;

    // 우선순위 큐
    List<MapEntry<String, double>> queue = [];
    queue.add(MapEntry(startStation, 0));

    while (queue.isNotEmpty) {
      // 최소 거리 노드 선택
      queue.sort((a, b) => a.value.compareTo(b.value));
      final current = queue.removeAt(0).key;

      // 이미 방문한 노드는 건너뜀
      if (visited.contains(current)) continue;
      visited.add(current);

      // 현재 노드 이웃 탐색
      for (var neighbor in graph[current] ?? []) {
        String nextStation = neighbor['station'];
        int edgeDistance = neighbor['distance'];
        int edgeDuration = neighbor['duration'];
        int edgeCost = neighbor['cost'];

        if (visited.contains(nextStation)) continue;

        // 새로운 거리, 시간, 비용 계산
        double newDistance = distances[current]! + edgeDistance;
        double newDuration = durations[current]! + edgeDuration;
        double newCost = costs[current]! + edgeCost;

        // 최단 거리 갱신
        if (newDistance < distances[nextStation]!) {
          distances[nextStation] = newDistance;
          durations[nextStation] = newDuration;
          costs[nextStation] = newCost;
          previousNodes[nextStation] = current;

          // 큐에 추가
          queue.add(MapEntry(nextStation, newDistance));
        }
      }
    }

    // 경로 구성
    List<String> path = [];
    String? currentNode = endStation;
    while (currentNode != null) {
      path.insert(0, currentNode);
      currentNode = previousNodes[currentNode];
    }

    // 환승 횟수 계산
    int transferCount = 0;
    for (int i = 1; i < path.length; i++) {
      if (path[i - 1][0] != path[i][0]) {
        transferCount++;
      }
    }

    return {
      "distance": distances[endStation]!.toInt(),
      "duration": durations[endStation]!.toInt(),
      "cost": costs[endStation]!.toInt(),
      "path": path,
      "transferCount": transferCount,
    };
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
                print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음');
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
            } else if (!snapshot.hasData || snapshot.data!.length < 2) {
              return Center(
                child: Text("출발역 또는 도착역 정보를 찾을 수 없습니다."),
              );
            }

            final startData = snapshot.data![0] as Map<String, dynamic>;
            final endData = snapshot.data![1] as Map<String, dynamic>;

            // 다익스트라 실행
            Map<String, dynamic> result = dijkstra(
                startData['routeInfo']['startStation'].toString(),
                endData['routeInfo']['endStation'].toString());

            // 결과 출력
            String? quickExit = startData['stationDetails']['quickExit'];
            String? doorSide = endData['facilityInfo']['doorSide'];

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text("출발역: ${widget.startStation}"),
                Text("도착역: ${widget.endStation}"),
                Text("경로: ${result['path'].join(' -> ')}"),
                Text("최단 거리: ${result['distance']} m"),
                Text("소요 시간: ${result['duration']} 초"),
                Text("비용: ${result['cost']} 원"),
                Text("환승 횟수: ${result['transferCount']}"),
                Text("출발역 Quick Exit: $quickExit"),
                Text("도착역 Door Side: $doorSide"),
              ],
            );
          },
        ),
      ),
    );
  }
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

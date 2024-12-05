import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/firebaseUtil.dart';

class MinimumTransfer extends StatefulWidget {
  final String startStation;
  final String endStation;

  const MinimumTransfer({
    Key? key,
    required this.startStation,
    required this.endStation,
  }) : super(key: key);

  @override
  _MinimumTransferState createState() => _MinimumTransferState();
}

class _MinimumTransferState extends State<MinimumTransfer> {
  late Future<Map<String, dynamic>?> startStationData;
  late Future<Map<String, dynamic>?> endStationData;
  static Map<String, List<Map<String, dynamic>>> graph = {};
  static bool graphBuilt = false;

  @override
  void initState() {
    super.initState();
    startStationData = fetchStationData(widget.startStation);
    endStationData = fetchStationData(widget.endStation);

    if (!graphBuilt) {
      buildGraph();
    }
  }

  Future<void> buildGraph() async {
    if (graphBuilt) return;

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

          graph.putIfAbsent(startStation, () => []);
          graph[startStation]!.add({
            'station': endStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });

          graph.putIfAbsent(endStation, () => []);
          graph[endStation]!.add({
            'station': startStation,
            'distance': distance,
            'duration': duration,
            'cost': cost,
          });
        }
      }

      graphBuilt = true;
    } catch (e) {
      print("그래프를 생성하는 동안 오류 발생: $e");
    }
  }

  Future<Map<String, dynamic>> dijkstra(
      String startStation, String endStation) async {
    if (!graph.containsKey(startStation) || !graph.containsKey(endStation)) {
      return {};
    }

    Map<String, double> durations = {};
    Map<String, String?> previousNodes = {};
    Set<String> visited = {};

    for (var station in graph.keys) {
      durations[station] = double.infinity;
      previousNodes[station] = null;
    }

    durations[startStation] = 0;

    List<MapEntry<String, double>> queue = [];
    queue.add(MapEntry(startStation, 0));

    while (queue.isNotEmpty) {
      queue.sort((a, b) => a.value.compareTo(b.value));
      final current = queue.removeAt(0).key;

      if (visited.contains(current)) continue;
      visited.add(current);

      for (var neighbor in graph[current] ?? []) {
        String nextStation = neighbor['station'];
        int edgeDuration = neighbor['duration'];

        if (visited.contains(nextStation)) continue;

        double newDuration = durations[current]! + edgeDuration;

        if (newDuration < durations[nextStation]!) {
          durations[nextStation] = newDuration;
          previousNodes[nextStation] = current;
          queue.add(MapEntry(nextStation, newDuration));
        }
      }
    }

    List<String> path = [];
    String? currentNode = endStation;
    while (currentNode != null) {
      path.insert(0, currentNode);
      currentNode = previousNodes[currentNode];
    }

    return {
      "duration": durations[endStation]!,
      "path": path,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text('최소 시간 길찾기').tr(),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Future.wait([startStationData, endStationData]),
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

          return FutureBuilder(
            future: dijkstra(
              startData['routeInfo']['startStation'].toString(),
              endData['routeInfo']['startStation'].toString(),
            ),
            builder:
                (context, AsyncSnapshot<Map<String, dynamic>> dijkstraResult) {
              if (dijkstraResult.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (dijkstraResult.hasError) {
                return Center(child: Text("최단 시간 경로 계산 중 오류 발생."));
              } else if (!dijkstraResult.hasData) {
                return Center(
                  child: Text("경로를 찾을 수 없습니다."),
                );
              }

              final result = dijkstraResult.data!;
              return _buildPageContent(result);
            },
          );
        },
      ),
    );
  }

  Widget _buildPageContent(Map<String, dynamic> result) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "소요 시간",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  "${(result['duration'] / 60).floor()}분 ${(result['duration'] % 60).toInt()}초",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4C4C4C),
                  ),
                ),
                Text(
                  "경로: ${result['path'].join(' → ')}",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

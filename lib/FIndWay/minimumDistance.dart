//최소 거리 길찾기 결과
/* 12.05 결국 라인 교집합일때의 조건을 해결 못함
거꾸로 갈때의 시간이 이상함

해보려고 했지만 할 수 없음
 */
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/FindWay/minimumTransfer.dart';
import 'package:flutter_application_1/widgets/findWay.dart';

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
  static Map<String, List<Map<String, dynamic>>> graph = {};
  static bool graphBuilt = false;

  bool isMinDistanceSelected = true;

  @override
  void initState() {
    super.initState();
    startStationData = fetchStationData(widget.startStation);
    endStationData = fetchStationData(widget.endStation);

    if (!graphBuilt) {
      buildGraph();
    }
  }

  //그래프 생성 함수
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

  //다익스트라 알고리즘 함수
  Future<Map<String, dynamic>> dijkstra(
      String startStation, String endStation) async {
    if (!graph.containsKey(startStation) || !graph.containsKey(endStation)) {
      return {};
    }

    Map<String, double> distances = {};
    Map<String, double> durations = {};
    Map<String, double> costs = {};
    Map<String, String?> previousNodes = {};
    Set<String> visited = {};

    for (var station in graph.keys) {
      distances[station] = double.infinity;
      durations[station] = double.infinity;
      costs[station] = double.infinity;
      previousNodes[station] = null;
    }

    distances[startStation] = 0;
    durations[startStation] = 0;
    costs[startStation] = 0;

    List<MapEntry<String, double>> queue = [];
    queue.add(MapEntry(startStation, 0));

    while (queue.isNotEmpty) {
      queue.sort((a, b) => a.value.compareTo(b.value));
      final current = queue.removeAt(0).key;

      if (visited.contains(current)) continue;
      visited.add(current);

      for (var neighbor in graph[current] ?? []) {
        String nextStation = neighbor['station'];
        int edgeDistance = neighbor['distance'];
        int edgeDuration = neighbor['duration'];
        int edgeCost = neighbor['cost'];

        if (visited.contains(nextStation)) continue;

        double newDistance = distances[current]! + edgeDistance;
        double newDuration = durations[current]! + edgeDuration;
        double newCost = costs[current]! + edgeCost;

        if (newDistance < distances[nextStation]!) {
          distances[nextStation] = newDistance;
          durations[nextStation] = newDuration;
          costs[nextStation] = newCost;
          previousNodes[nextStation] = current;
          queue.add(MapEntry(nextStation, newDistance));
        }
      }
    }

    //경로를 path에 담음
    List<String> path = [];
    String? currentNode = endStation;
    while (currentNode != null) {
      path.insert(0, currentNode);
      currentNode = previousNodes[currentNode];
    }

    Map<String, List<int>> lineData =
        await fetchLineData(path); //경로에 해당하는 라인 정보를 담기 위해
    int transferCount = calculateTransfers(lineData); //라인정보로 환승횟수를 계산하기 위해

    //UIDetail에서 환승정보에 대한 역 정보들을 가져와서 findway에 넘길 값 저장
    List<Map<String, dynamic>> uiDetails = await generateUIDetails(
      path,
      lineData,
      durations,
    );

    return {
      "distance": distances[endStation]!,
      "duration": durations[endStation]!,
      "cost": costs[endStation]!,
      "path": uiDetails,
      "transferCount": transferCount,
    };
  }

  //path에 담긴 경로에 해당하는 라인값을 lineData에 담음
  Future<Map<String, List<int>>> fetchLineData(List<String> path) async {
    Map<String, List<int>> lineData = {};

    for (int i = 0; i < path.length; i++) {
      final stationData = await fetchStationData(path[i]);

      if (stationData != null && stationData.containsKey('line')) {
        List<int> currentLines = List<int>.from(stationData['line']);

        if (i < path.length - 1) {
          // 다음 역 데이터 가져오기
          final nextStationData = await fetchStationData(path[i + 1]);

          if (nextStationData != null && nextStationData.containsKey('line')) {
            List<int> nextLines = List<int>.from(nextStationData['line']);
            // 현재 라인과 다음 라인의 중복값 계산
            List<int> commonLines =
                currentLines.where((line) => nextLines.contains(line)).toList();

            // 중복값이 있으면 중복값을 넣고 없으면 현재 라인을 추가
            lineData[path[i]] =
                commonLines.isNotEmpty ? commonLines : currentLines;
          } else {
            // 다음 역 데이터가 없는 경우 현재 라인을 그대로 추가
            lineData[path[i]] = currentLines;
          }
        } else {
          // 마지막 역일 경우 현재 라인을 그대로 추가
          lineData[path[i]] = currentLines;
        }
      } else {
        // 현재 역 데이터가 없으면 빈 리스트로 설정
        lineData[path[i]] = [];
      }
    }

    return lineData;
  }

  //환승횟수세기
  int calculateTransfers(Map<String, List<int>> lineData) {
    int transferCount = 0;
    List<int> currentLines = lineData.entries.first.value;

    for (var entry in lineData.entries.skip(1)) {
      if (currentLines.every((line) => !entry.value.contains(line))) {
        transferCount++;
        currentLines = entry.value;
      }
    }

    return transferCount;
  }

//findWay에서 가져온 UI를 가져와서 출력
  Future<List<Map<String, dynamic>>> generateUIDetails(
    List<String> path,
    Map<String, List<int>> lineData,
    Map<String, double> durations, // duration 값을 받음
  ) async {
    List<Map<String, dynamic>> uiDetails = [];
    List<int> currentLines = lineData[path.first] ?? [];

    // Firebase에서 특정 역 정보 가져오는 함수
    Future<Map<String, dynamic>> fetchStationDetails(String stationName) async {
      final snapshot = await FirebaseFirestore.instance
          .collection('station')
          .doc(stationName)
          .get();
      return snapshot.data() ?? {};
    }

    // 해당 구간의 duration을 누적하는 함수
    double durationSum(List<String> path, Map<String, double> durations) {
      double sum = 0;

      // 경로를 순회하면서 누적
      for (int i = 1; i < path.length; i++) {
        // 이전 역의 duration 값을 가져와 누적
        sum += durations[path[i - 1]] ?? 0;
      }

      return sum;
    }


    // 첫 출발역 추가
    final firstStationDetails = await fetchStationDetails(path.first);
    uiDetails.add({
      "line": currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path.first,
      "quickExit": firstStationDetails['stationDetails']?['quickExit'] ?? "",
      "doorSide": "", // 첫 출발역에서는 내리는 문 정보 없음
      "duration": "", // 초기값
    });

// 경로 순회하면서 환승 정보를 추가
for (int i = 0; i <= path.length; i++) {
  // 현재 구간의 duration
  double currentSegmentDuration = durations[path[i]] ?? 0;

  // 누적 시간을 계산
  double totalDuration = durationSum(path.sublist(0, i + 1), durations);

  // 환승이 발생한 경우
  if (currentLines
      .every((line) => !(lineData[path[i]] ?? []).contains(line))) {
    // 환승 전 도착역
    final prevStationDetails = await fetchStationDetails(path[i]);
    uiDetails.add({
      "line":
          currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path[i], // 환승 전 도착역
      "quickExit": "", // 중간 도착역에서는 빠른 하차 정보 없음
      "doorSide": prevStationDetails['facilityInfo']?['doorSide'] ?? "",
      "duration": totalDuration.toInt() - currentSegmentDuration.toInt(), // 해당 구간의 duration만 빼기
    });

    // 현재 라인의 업데이트
    currentLines = lineData[path[i]] ?? [];

    // 환승 후 출발역
    final nextStationDetails = await fetchStationDetails(path[i]);
    uiDetails.add({
      "line":
          currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path[i], // 환승 후 출발역
      "quickExit": nextStationDetails['stationDetails']?['quickExit'] ?? "",
      "doorSide": "", // 출발역에서는 내리는 문 정보 없음
      "duration": "", // 환승 후 출발 시점에서는 duration 출력하지 않음
    });
  }
}


    // 최종 도착역 추가
    final lastStationDetails = await fetchStationDetails(path.last);
    uiDetails.add({
      "line": currentLines.isNotEmpty ? currentLines.first.toString() : "N/A",
      "stationName": path.last,
      "quickExit": "", // 최종 도착역에서는 빠른 하차 정보 없음
      "doorSide": lastStationDetails['facilityInfo']?['doorSide'] ?? "",
      "duration":
          durations[path[path.length - 2]]?.toInt() ?? 0, // 최종 구간의 duration
    });

    return uiDetails;
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
        title: Text('길찾기').tr(),
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
                return Center(child: Text("최단 경로 계산 중 오류 발생."));
              } else if (!dijkstraResult.hasData) {
                return Center(
                  child: Text("경로를 찾을 수 없습니다."),
                );
              }

              final result = dijkstraResult.data!;
              return _buildPageContent(result, startData, endData);
            },
          );
        },
      ),
    );
  }

  Widget _buildPageContent(Map<String, dynamic> result,
      Map<String, dynamic> startData, Map<String, dynamic> endData) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildButton('최소 거리 순', isMinDistanceSelected, () {
                setState(() {
                  isMinDistanceSelected = true;
                });
              }),
              SizedBox(width: 10),
              _buildButton('최소 환승 순', !isMinDistanceSelected, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MinimumTransfer(
                      startStation: widget.startStation,
                      endStation: widget.endStation,
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    // 소요 시간 텍스트
                    Text(
                      "소요 시간",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    // 소요 시간 값
                    Text(
                      "${(result['duration'] / 60).floor()}분 ${(result['duration'] % 60).toInt()}초",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4C4C4C),
                      ),
                    ),
                    SizedBox(height: 5), // 항목 간의 간격

                    // 환승 정보, 비용 정보, 거리 정보는 한 줄로 배치
                    Text(
                      "환승 ${result['transferCount']}회 | 비용 ${result['cost']}원 | 거리 ${(result['distance'] / 1000).toStringAsFixed(2)}km",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          _buildTravelDetails(result['path']),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool isSelected, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff397394) : Colors.white,
          border: Border.all(color: Color(0xff397394)),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Color(0xff397394),
          ),
        ),
      ),
    );
  }

  //findway에 값을 넘겨주기 위함
  Widget _buildTravelDetails(List<Map<String, dynamic>> uiDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: uiDetails.map((detail) {
        return findWay(
          lineNumber: detail['line'].toString(),
          stationName: detail['stationName'],
          quickExit: detail['quickExit'] ?? "",
          doorSide: detail['doorSide'] ?? "",
          duration: detail['duration'] != ""
              ? "${(detail['duration'] / 60).floor()}분 ${(detail['duration'] % 60).toInt()}초"
              : "", // duration이 비어있을 경우 출력하지 않음
        );
      }).toList(),
    );
  }
}

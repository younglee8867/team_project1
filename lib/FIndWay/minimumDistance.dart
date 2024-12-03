// 최소거리화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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

  @override
  void initState() {
    super.initState();
    startStationData = fetchStationData(widget.startStation);
    endStationData = fetchStationData(widget.endStation);
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
          future: Future.wait([startStationData, endStationData]),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>?>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
            } else if (!snapshot.hasData ||
                snapshot.data!.any((data) => data == null)) {
              return Center(
                child: Text("출발역 또는 도착역 정보를 찾을 수 없습니다."),
              );
            }

            final startData = snapshot.data![0];
            final endData = snapshot.data![1];
            final distance = (endData!['routeInfo']['distance'] as int) -
                (startData!['routeInfo']['distance'] as int);

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 120),
                            child: _buildCircleWithText(widget.startStation),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          _buildStationInfo(startData),
                          _buildStationInfo(endData),
                          _buildTravelDetails(distance),
                        ],
                      ),
                    ),
                  ],
                ),
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
        "출발역과 도착역 간 거리: $distance m",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

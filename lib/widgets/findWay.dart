// 길찾기 위젯
// 행{숫자동그라미 {열(역이름 - (행)부가정보)}}
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';
import 'package:flutter_application_1/constants/lineColor.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/firebaseUtil.dart';

/* void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Way Widget',
      home: const findWayItem(stationName: '101'),
    );
  }
} */

class findWay extends StatelessWidget {
  final String lineNumber;
  final String stationName;
  final String quickExit;
  final String doorSide;
  final String duration;

  const findWay({
    Key? key,
    required this.lineNumber,
    required this.stationName,
    this.quickExit = '',
    this.doorSide = '',
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              // 조건: quickExit.isNotEmpty일 경우 원 + 선 추가, 아니면 원만 추가
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: SubwayColors.getColor(lineNumber), // 라인별로 색상 지정
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    lineNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (quickExit.isNotEmpty)
                Container(
                  width: 8, // 세로선의 너비
                  height: 60, // 세로선의 길이
                  color: SubwayColors.getColor(lineNumber), // 선 색상 지정
                ),
            ],
          ),
          const SizedBox(width: 16),
          // 역 정보 (항상 출력)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              children: [
                // 역 이름
                Text(
                  stationName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4C4C4C),
                  ),
                ),
                const SizedBox(height: 4), // 역 이름과 아래 정보 간격
                // 소요 시간 및 추가 정보
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    if (quickExit.isNotEmpty || doorSide.isNotEmpty)
                      Text(
                        [
                          if (quickExit.isNotEmpty) '빠른 하차: $quickExit',
                          if (doorSide.isNotEmpty) '내리는 문: $doorSide | ',
                        ].join(' | '),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    Text(
                      duration,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

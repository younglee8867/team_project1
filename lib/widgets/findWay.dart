// 길찾기 위젯
// 행{숫자동그라미 {열(역이름 - (행)부가정보)}}
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';
import 'package:flutter_application_1/constants/lineColor.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/firebaseUtil.dart';

/*void main() {
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
}위젯만 따로 테스트*/


class findWayItem extends StatelessWidget {
  final String stationName;
  
  const findWayItem({
    Key? key,
    required this.stationName,
  }) : super(key: key);

  // 숫자만 추출하는 함수
  String extractNumber(String input) {
    final RegExp numberRegex = RegExp(r'\d+'); // 숫자에 해당하는 정규식
    final match = numberRegex.firstMatch(input);
    // 근데 여기에 환승하는 역 색상코드땜에 따로 함수 써야함(12.04)
    // 만약 디비에 Line이 2개 이상이다? --> 그럼 ...음...
    
    return match?.group(0) ?? ''; // 숫자가 없으면 빈 문자열 반환
  }


@override
Widget build(BuildContext context) {
  final colorLine = SubwayColors.getColor(stationName.substring(0, 1));

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center, // 수직 정렬 중앙
      mainAxisSize: MainAxisSize.min, // Row의 크기를 최소한으로 설정
      children: [
        // 숫자 동그라미
        Container(
          width: 44, 
          height: 44,
          decoration: BoxDecoration(
            color: colorLine, 
            shape: BoxShape.circle, 
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle(
             // 숫자 표시
            style: const TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 22, 
            ),
            child: Text(extractNumber(stationName).substring(0, 1)),
          ),

        ),
        const SizedBox(width: 20), 
        // 역 정보
        SizedBox(
          width: 200, // 고정 너비
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff4C4C4C),
                  fontWeight: FontWeight.bold,
                ),
                child: Text(stationName),
              ),
              const SizedBox(height: 5), // 이름과 부가정보 사이 간격
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff979797),
                ),
                child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '내리는 문 ',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: '오른쪽', //'${facilityInfo['doorSide']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, 
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(
                          text: '       빠른 하차 ',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextSpan(
                          text: '3-2', //'${stationDetails['quickExit']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold, 
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ],
    ),
      ],
    ) 

  );
}




}

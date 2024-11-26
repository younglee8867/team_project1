// 지역설정 화면
//11.25 사이드 바 없애고 페이지 구성으로 바꿈
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegionSettingsPage(),
    );
  }
}

class RegionSettingsPage extends StatelessWidget {
  const RegionSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF22536F)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          '지역 설정',
          style: TextStyle(
            color: Color(0xFF22536F),
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView(
        children: const [
          RegionButton(region: '수도권'),
          Divider(thickness: 1, height: 1),
          RegionButton(region: '부산'),
          Divider(thickness: 1, height: 1),
          RegionButton(region: '대구'),
          Divider(thickness: 1, height: 1),
          RegionButton(region: '광주'),
          Divider(thickness: 1, height: 1),
          RegionButton(region: '대전'),
          Divider(thickness: 1, height: 1),
        ],
      ),
    );
  }
}

class RegionButton extends StatelessWidget {
  final String region;

  const RegionButton({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        region,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF22536F),
          fontFamily: 'Roboto', // 텍스트 컬러 설정
        ),
      ),
      onTap: () {
        // 버튼 눌렀을 때 별다른 동작 없음
      },
    );
  }
}

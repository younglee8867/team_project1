import 'package:flutter/material.dart';

class DisplayModePage extends StatefulWidget {
  const DisplayModePage({super.key});

  @override
  State<DisplayModePage> createState() => _DisplayModePageState();
}

class _DisplayModePageState extends State<DisplayModePage> {
  // 상태 변수
  bool isLightModeSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('화면 모드'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('라이트 모드'),
            Radio<int>(
              value: 1,
              groupValue: isLightModeSelected ? 1 : 0,
              onChanged: (value) {
                setState(() {
                  isLightModeSelected = value == 1;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('다크 모드'),
            Radio<int>(
              value: 0,
              groupValue: isLightModeSelected ? 1 : 0,
              onChanged: (value) {
                setState(() {
                  isLightModeSelected = value == 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

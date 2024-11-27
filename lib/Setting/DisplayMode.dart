// 화면모드 설정 화면
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '화면 모드',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
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

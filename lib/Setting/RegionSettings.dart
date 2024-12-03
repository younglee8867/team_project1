import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegionSettingsPage extends StatefulWidget {
  const RegionSettingsPage({super.key});

  @override
  State<RegionSettingsPage> createState() => _RegionSettingsPage();
}

class _RegionSettingsPage extends State<RegionSettingsPage> {
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
          child: const Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          '지역 설정'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(
          children: const [
            RegionButton(region: '수도권'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '부산'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '대구'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '광주'),
            Divider(thickness: 1, height: 1),
            SizedBox(height: 30),
            RegionButton(region: '대전'),
            Divider(thickness: 1, height: 1),
          ],
        ),
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
        region.tr(), // 번역 키를 통해 다국어 적용
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF22536F),
          fontFamily: 'Roboto',
        ),
      ).tr(),
      onTap: () {
        // 버튼 눌렀을 때 별다른 동작 없음
      },
    );
  }
}

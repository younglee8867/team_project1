import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPage createState() => _PrivacyPolicyPage();
}

class _PrivacyPolicyPage extends State<PrivacyPolicyPage> {
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
          '개인정보 처리 방침',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '\n<스마트 환승철>은(는) 정보주체의 자유와 권리 보호를 위해 「개인정보 보호법」및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. \n\n이에 「개인정보 보호법」 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.\n\n',
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '주요 개인정보 처리 표시\n\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '일반 개인정보의 수집\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보 처리 목적\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 제공\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 파기\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '개인정보의 보유 기간\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '민감정보 수집\n'.tr(),
                      style: TextStyle(
                        color: Color(0xFF22536F),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/PrivacyTerm.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({super.key});

  @override
  _TermsOfServicePage createState() => _TermsOfServicePage();
}

class _TermsOfServicePage extends State<TermsOfServicePage> {
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
          '이용약관'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    // 제1조
                    TextSpan(
                      text: '제1조 (목적)'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '\n', style: TextStyle(fontSize: 14)),

                    TextSpan(
                      text:
                          '스마트환승철(이하 “회사”라 합니다)는 회사가 제공하는 지하철 서비스에 대한 약관을 마련하였습니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '본 약관은 회사와 회원의 권리와 의무, 책임관계, 기타 필요한 사항을 규정하고 있습니다.'
                          .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    // 줄바꿈
                    TextSpan(text: '\n\n', style: TextStyle(fontSize: 14)),

                    // 제2조
                    TextSpan(
                      text: '제2조 (정의)'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '\n', style: TextStyle(fontSize: 14)),

                    TextSpan(
                      text: '본 약관에서 사용하는 용어의 뜻은 다음과 같습니다.'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text:
                          '스마트환승철: 회원이 휴대전화 등을 통하여 지하철 서비스를 이용할 수 있도록 회사가 제공하는 일체의 어플리케이션을 말합니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '스마트환승철 서비스: 스마트환승철을 통해서 제공하는 일체의 서비스를 의미합니다.'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text:
                          '회원: 본 약관에 동의하고, 회사가 제공하는 스마트환승철 서비스 전체를 이용하는 고객을 말합니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '회원이 아니어도 정보제공 서비스는 이용할 수 있습니다.'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    // 줄바꿈
                    TextSpan(text: '\n\n', style: TextStyle(fontSize: 14)),

                    // 제3조
                    TextSpan(
                      text: '제3조 (약관의 효력 및 변경)'.tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '\n', style: TextStyle(fontSize: 14)),

                    TextSpan(
                      text:
                          '본 약관의 내용은 스마트환승철 화면에 게시하거나 기타의 방법으로 회원에게 공시하고, 본 약관에 동의한 회원에게 그 효력이 있습니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '회사는 필요한 경우 관련법령을 위배하지 않는 범위 내에서 본 약관을 변경할 수 있습니다.'
                          .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text:
                          '회사가 본 약관을 변경할 경우에는 적용일자, 변경사유를 명시하여 적용일자 7일 전부터 공지하거나, 회원에게 개별 통지합니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text:
                          '회원에게 불리한 약관의 변경인 경우에는 그 적용일자 30일 전부터 공지하거나, 회원에게 개별 통지합니다.'
                              .tr(),
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 13,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

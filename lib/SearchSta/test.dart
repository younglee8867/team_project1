/* 역검색 결과 임시 코드
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../util/util.dart';

class SearchStaInfo extends StatefulWidget {
  final List<Map<String, dynamic>> searchHistory;
  

  const SearchStaInfo({Key? key, required this.searchHistory})
      : super(key: key);

  @override
  _SearchStaInfo createState() => _SearchStaInfo();
}

class _SearchStaInfo extends State<SearchStaInfo> {

  

  @override
  Widget build(BuildContext context) {
    final searchHistory = widget.searchHistory;

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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
body: ListView(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  children: [
    Column(
      children: [
        Stack(
          children: [
            _buildMapImage(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 120), // 위쪽으로 50px의 간격 추가
              child: _buildCircleWithText(searchHistory),
            ),
          ),
          ],
        ),
        const SizedBox(height: 20),
        _buildStationNavigationAndButtons(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              _buildStationInfo(data['stationDetails']), // 역정보
              _buildFacilityInfo(data['facilityInfo']), // 시설정보
              _buildConvenienceInfo(data['amenities']), // 편의시설
              _buildWeatherInfo(data['weatherInfo']), // 날씨 정보
            ],
          ),
        ),
      ],
    ),
  ],
  )

);
  }

 
  Widget _buildStationButton(String label) {
    return GestureDetector(
      /*onTap: () {
        Navigator.pop(context); // 버튼 동작 구현
      },*/
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 31,
        decoration: BoxDecoration(
          color: Color(0xFF686868),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

// 이전역, 다음역 및 출발역, 도착역 버튼
Widget _buildStationNavigationAndButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이템 간 간격 설정
    children: [
      // 이전역
      _buildStationNavigation('이전역', false),

      // 출발역과 도착역을 하나로 묶음
      Row(
        children: [
          _buildStationButton('출발역'),
          const SizedBox(width: 10), // 출발역과 도착역 사이 간격
          _buildStationButton('도착역'),
        ],
      ),

      // 다음역
      _buildStationNavigation('다음역', true),
    ],
  );
}

    // 이전역, 다음역
  Widget _buildPreviousNextStations() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStationNavigation('이전역', false),
        _buildStationNavigation('다음역', true),
      ],
    );
  }

  Widget _buildStationNavigation(String label, bool isNext) {
    return Row(
      children: [
        if (!isNext)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/images/Chevron_left_right.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Color(0xff676363),
            fontSize: 16,
          ),
        ),
        if (isNext)
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14159),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('../assets/images/Chevron_left_right.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // 출발역, 도착역 버튼
  Widget _buildStationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStationButton('출발역'),
        _buildStationButton('도착역'),
      ],
    );
  }

 



  // 공통 섹션 레이아웃
  Widget _buildSection({required String title, required Widget content}) {
    // 글씨 스타일 속성
    final TextStyle commonTextStyle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 22,
    fontFamily: 'Roboto',
    height: 0.5,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w800,
  );

  final TextStyle detailTextStyleTitle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 20,
    fontFamily: 'Roboto',
    height: 0.1,
    letterSpacing: 0.5,
  );


    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: commonTextStyle),
          SizedBox(height: 10),
          content,
          Divider(color: Colors.grey, thickness: 0.5),
        ],
      ),
    );
}

Widget _buildDetailText(String label, String value) {
  // 스타일 속성 정의
  final TextStyle detailTextStyle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 18,
    fontFamily: 'Roboto',
    height: 0.5, // 텍스트 줄 간격
    letterSpacing: 0.5,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0), // 위아래 간격 추가
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label, style: detailTextStyle),
          TextSpan(
            text: value,
            style: detailTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}*/
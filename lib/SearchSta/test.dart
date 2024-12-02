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

  // 지도 이미지
  Widget _buildMapImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/station/StationMap.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }

  // 동그라미(호선)와 역 이름
  Widget _buildCircleWithText(List<Map<String, dynamic>> searchHistory) {
    return Column(
      children: [
        // 호선 색깔
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.brown, width: 10),
          ),
          alignment: Alignment.center,
          // 호선 번호 (ex. 1,2,3..)
          child: Text(
            searchHistory.isNotEmpty
                ? searchHistory[0]['name'][0]
                : '0',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // 세로 정렬 중앙
          children: [
            // 역 이름을 가로 중앙에 배치
            Expanded(
              child: Text(
                searchHistory.isNotEmpty
                    ? searchHistory[0]['name'] + " "+"역".tr()
                    : '알 수 없음',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  height: 1.5,
                ),
                textAlign: TextAlign.center, // 텍스트를 가운데 정렬
              ),
            ),
            // 별 아이콘
                  GestureDetector(
                    //onTap: onToggleFav,
                    child: Image.asset(
                      'assets/images/favStar.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
          ],
        )
        )



      ],
    );
  }
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

 // 역 정보
  Widget _buildStationInfo() {
    return _buildSection(
      title: '역 정보',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          SizedBox(height: 20), // 제목과 내용 사이 간격
          Row(
            children: [
              _buildDetailText('배차시간 ', '7분'),
              SizedBox(width: 70), // 두 정보 사이 간격
              _buildDetailText('빠른하차 ', '3-5'),
              SizedBox(height: 20),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }


  // 시설 정보
  Widget _buildFacilityInfo() {
    return _buildSection(
      title: '시설 정보',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          SizedBox(height: 20), // 제목과 내용 사이 간격
          Row(
            children: [
              _buildDetailText('내리는문 ', '오른쪽'),
              SizedBox(width: 70), // 두 정보 사이 간격
              _buildDetailText('화장실 ', '50m'),
            ],
          ),
          SizedBox(height: 20), // 행과 행 사이 간격
          _buildDetailText('플랫폼 ', '양쪽'),
          SizedBox(height: 20),
        ],
        
      ),
    );
  }


  // 편의시설
  Widget _buildConvenienceInfo() {
    return _buildSection(
      title: '편의 시설',
      content: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              _buildDetailText('편의점 / 카페', ''),
              SizedBox(width: 70),
              _buildDetailText('유실물센터', ''),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _buildDetailText('물품보관소', ''),
              SizedBox(width: 85),
              _buildDetailText('엘리베이터', ''),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

// 날씨 정보
Widget _buildWeatherInfo() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16), // 양쪽 패딩 설정
    child: Container(
      width: double.infinity, // 화면 너비에 맞춤
      height: 94,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(2, 6),
            blurRadius: 7,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '날씨 정보 표시 영역',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
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
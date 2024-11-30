// 역검색 결과 화면
// 11.24 지도위에 노선 번호가 걸쳐지게 구현
// 11.24 실제로 usb디버깅 하면서 UI 배치해야할 것 같음
// 11.24 즐겨찾기 기능 구현
// 11.24 데이터 불러오고 수정하겠습니다.......

import 'package:flutter/material.dart';
import '../util/util.dart';

class searchStaInfo extends StatefulWidget {
  final List<Map<String, dynamic>> searchHistory;

  const searchStaInfo({required this.searchHistory});

  @override
  _searchStaInfo createState() => _searchStaInfo();
}

class _searchStaInfo extends State<searchStaInfo> {
  late List<Map<String, dynamic>> resultOfStations;

  @override
  void initState() {
    super.initState();
    resultOfStations =
        widget.searchHistory.isNotEmpty ? widget.searchHistory : [];
  }

  String imagePath = '../assets/images/favStar.png';

  void _toggleFavorite(int index) {
    setState(() {
      toggleFavorite(resultOfStations, index);
    });
  }

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

  final TextStyle detailTextStyle = TextStyle(
    color: Color(0xFF676363),
    fontSize: 15,
    fontFamily: 'Roboto',
    height: 0.1,
    letterSpacing: 0.5,
  );

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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // 지도와 동그라미
          Column(
            children: [
              // 지도 이미지
              _buildMapImage(),

              // 동그라미와 텍스트를 지도 아래쪽으로 배치
              //Positioned(
              //top: 900, // 동그라미를 지도 아래로 조정
              //left: MediaQuery.of(context).size.width / 2 - 62.5, // 동그라미를 화면 중앙에 배치
              _buildCircleWithText(),
              //),
            ],
          ),
          SizedBox(height: 20),

          // 출발역, 도착역 버튼
          _buildStationButtons(),
          SizedBox(height: 10),

          // 이전역, 다음역
          _buildPreviousNextStations(),
          SizedBox(height: 35),

          // 역정보
          _buildStationInfo(),
          //SizedBox(height: 10),

          // 시설정보
          _buildFacilityInfo(),
          //SizedBox(height: 10),

          // 편의시설
          _buildConvenienceInfo(),
          //SizedBox(height: 35),

          // 날씨정보
          _buildWeatherInfo(),
        ],
      ),
    );
  }

  // 지도 이미지
  Widget _buildMapImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('../assets/images/StationMap.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }

  // 동그라미와 텍스트
  Widget _buildCircleWithText() {
    bool isFavorite = false;
    VoidCallback _toggleFavorite;
    return Positioned(
      top: 500, // 지도 아래로 내려오도록 설정 (지도 높이 + 동그라미 위치 조정)
      child: Column(
        children: [
          // 흰 동그라미
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.brown, width: 10),
            ),
            alignment: Alignment.center,
            child: Text(
              resultOfStations.isNotEmpty
                  ? resultOfStations[0]['name'][0]
                  : '0',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  resultOfStations.isNotEmpty
                      ? resultOfStations[0]['name']
                      : '알 수 없음',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  // Toggle favorite logic
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  // 출발역, 도착역 버튼
  Widget _buildStationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStationButton('출발역'),
        SizedBox(width: 20),
        _buildStationButton('도착역'),
      ],
    );
  }

  Widget _buildStationButton(String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // 버튼 동작 구현
      },
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
    return _buildSection(
      title: '날씨 정보',
      content: Padding(
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
                offset: Offset(2, 6),
                blurRadius: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 공통 섹션 레이아웃
  Widget _buildSection({required String title, required Widget content}) {
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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label, style: detailTextStyle),
          TextSpan(
            text: value,
            style: detailTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

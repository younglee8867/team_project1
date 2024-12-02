/*
[12.02] 데베 연동 성공
수정사항 1. 화면 UI
수정사항 2. 즐찾기능 추가
*/
import 'package:flutter/material.dart';
import '../util/firebaseUtil.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchStaInfo extends StatefulWidget {
  final String stationName;

  const SearchStaInfo({Key? key, required this.stationName, required List<Map<String, dynamic>> searchHistory})
      : super(key: key);

  @override
  _SearchStaInfo createState() => _SearchStaInfo();
}

class _SearchStaInfo extends State<SearchStaInfo> {
  late Future<Map<String, dynamic>?> stationData;

  @override
  void initState() {
    super.initState();
    stationData = fetchStationData(widget.stationName); 
    // 검색한 역 값(ex.101)을 파라메터로 전달
    // util/firebaseUtil.dart에서 정의한 함수로 데이터베이스에 해당 값 있는지 확인
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( // 뒤로 가기
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: stationData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("역 정보를 찾을 수 없습니다. ${widget.stationName}"));
          }

          final data = snapshot.data!;
          return ListView(
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
                        child: _buildCircleWithText(widget.stationName),
                      ),
                    ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //_buildStationNavigationAndButtons(),
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
            );
        },
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
  Widget _buildCircleWithText(String stationName) {
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
            stationName.isNotEmpty
                ? stationName.substring(0,1)
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
                stationName.isNotEmpty
                    ? stationName + " "+"역".tr()
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

// 역 정보
  Widget _buildStationInfo(Map<String, dynamic>? stationDetails) {
    if (stationDetails == null) return SizedBox();

    return _buildSection(
      title: '역 정보',
      content: Column(
        children: [
          //_buildDetailText('배차시간', stationDetails['schedule']),
          _buildDetailText('빠른하차', stationDetails['quickExit']),
        ],
      ),
    );
  }

// 시설 정보
  Widget _buildFacilityInfo(Map<String, dynamic>? facilityInfo) {
    if (facilityInfo == null) return SizedBox();

    return _buildSection(
      title: '시설 정보',
      content: Column(
        children: [
          _buildDetailText('내리는문', facilityInfo['doorSide']),
          _buildDetailText('화장실', facilityInfo['restrooms']),
          _buildDetailText('플랫폼', facilityInfo['platformType']),
        ],
      ),
    );
  }

// 편의 시설
  Widget _buildConvenienceInfo(Map<String, dynamic>? amenities) {
    if (amenities == null) return SizedBox();

    return _buildSection(
      title: '편의 시설',
      content: Column(
        children: [
          _buildDetailText('편의점 / 카페', amenities['store'] ? '있음' : '없음'),
          _buildDetailText('유실물센터', amenities['foundCenter'] ? '있음' : '없음'),
          _buildDetailText('물품보관소', amenities['storageRoom'] ? '있음' : '없음'),
          _buildDetailText('엘리베이터', amenities['elevator'] ? '있음' : '없음'),
        ],
      ),
    );
  }

// 날씨 정보
  Widget _buildWeatherInfo(Map<String, dynamic>? weatherInfo) {
    if (weatherInfo == null) return SizedBox();

    return _buildSection(
      title: '날씨 정보',
      content: Center(
        child: Text(
          '${weatherInfo['condition']} (${weatherInfo['temperature']})',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

// 공통 위젯
  Widget _buildSection({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          content,
          Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
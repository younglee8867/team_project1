/*
[12.02] 데베 연동 성공
수정사항 1. 화면 UI
수정사항 2. 즐찾기능 추가
수정사항 3. 출발역, 도착역 클릭시 -> 길찾기로(해당역)
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FIndWay/WriteStation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/firebaseUtil.dart';
import 'package:flutter_application_1/util/firebaseGetPrev.dart';
import 'package:easy_localization/easy_localization.dart';
import '../util/util.dart';
import '../constants/lineColor.dart';

class SearchStaInfo extends StatefulWidget {
  final String stationName;

  const SearchStaInfo(
      {Key? key,
      required this.stationName,
      required List<Map<String, dynamic>> searchHistory})
      : super(key: key);

  @override
  _SearchStaInfo createState() => _SearchStaInfo();
}

class _SearchStaInfo extends State<SearchStaInfo> {
  List<Map<String, dynamic>> _searchHistory = SharedStationData.searchHistory;
  late Future<Map<String, dynamic>?> stationData;
  late Future<bool> isFavorite;

  @override
  void initState() {
    super.initState();
    stationData = fetchStationData(widget.stationName);
    isFavorite = _loadFavoriteStatus(widget.stationName);
  }

  Future<bool> _loadFavoriteStatus(String stationName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(stationName) ?? false;
  }

  Future<void> _toggleFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final currentStatus =
        await _loadFavoriteStatus(_searchHistory[index]['name']);

    setState(() {
      isFavorite = Future.value(!currentStatus);
      SharedStationData.toggleFavoriteStatus(widget.stationName);
    });

    await prefs.setBool(widget.stationName, !currentStatus);
    print('${widget.stationName} 즐겨찾기 상태: ${!currentStatus}');
  }

  /*void _toggleFavorite(int index) {
    setState(() {
      SharedStationData.toggleFavoriteStatus(widget.stationName);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context, true); // 데이터를 갱신하도록 플래그 전달
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
            return Center(
                child: Text("역 정보를 찾을 수 없습니다. ${widget.stationName}"));
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
                          padding: const EdgeInsets.only(
                              top: 120), // 위쪽으로 50px의 간격 추가
                          child: _buildCircleWithText(widget.stationName),
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
    bool isFavorite = false;

    // 즐겨찾기 상태 로드
    Future<void> _loadFavoriteStatus() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isFavorite = prefs.getBool(stationName) ?? false;
      });
    }

    // 즐겨찾기 상태 토글
    Future<void> _toggleFavorite() async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        isFavorite = !isFavorite;
      });
      await prefs.setBool(stationName, isFavorite);
      print('$stationName 즐겨찾기 상태: $isFavorite');
    }

    // 첫 로드 시 즐겨찾기 상태 가져오기
    _loadFavoriteStatus();

    // 각 호선마다 색상 가져오기
    final color = SubwayColors.getColor(stationName.substring(0, 1));

    return Column(
      children: [
        // 호선 색깔
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 10), // 색 지정
          ),
          alignment: Alignment.center,
          // 호선 번호 (ex. 1,2,3..)
          child: Text(
            stationName.isNotEmpty ? stationName.substring(0, 1) : '0',
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
                      ? stationName + " " + "역".tr()
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

              // 즐겨찾기 아이콘
              GestureDetector(
                onTap: () async {
                  // 즐겨찾기 상태를 반전
                  await _toggleFavorite();
                },
                child: Image.asset(
                  isFavorite
                      ? 'assets/images/favStarFill.png' // 즐겨찾기 상태일 때 채워진 별
                      : 'assets/images/favStar.png', // 즐겨찾기 상태가 아닐 때 빈 별
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// 이전역, 다음역 및 출발역, 도착역 버튼
  Widget _buildStationNavigationAndButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이템 간 간격 설정
      children: [
        // 이전역
        _buildStationNavigation('이전역'.tr(), false),

        // 출발역과 도착역 (클릭시 해당 값과 함께 페이지 이동)
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WriteStationPage(
                            initialStartStation: widget.stationName,
                            searchHistory: [],
                          )),
                ); // 버튼 동작 구현
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
                  '출발역'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),

            const SizedBox(width: 10), // 출발역과 도착역 사이 간격
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WriteStationPage(
                            initialEndStation: widget.stationName,
                            searchHistory: [],
                          )),
                ); // 버튼 동작 구현
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
                  '도착역'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),

        // 다음역
        _buildStationNavigation('다음역'.tr(), true),
      ],
    );
  }

// 이전역 다음역
  Widget _buildStationNavigation(String label, bool isNext) {
    return Row(
      children: [
        if (!isNext)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Chevron_left_right.png'),
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
                  image: AssetImage('assets/images/Chevron_left_right.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }

// 역 정보
  Widget _buildStationInfo(Map<String, dynamic>? stationDetails) {
    if (stationDetails == null) return SizedBox();

    return _buildSection(
      title: '역 정보'.tr(),
      content: Row(
        children: [
          _buildDetailText(
              '배차시간'.tr(),
              stationDetails['schedule']?['interval'] != null
                  ? '${stationDetails['schedule']?['interval']}${'분'.tr()}'
                  : '정보 없음'.tr()),
          SizedBox(width: 20),
          _buildDetailText_lastTime(
              '막차'.tr(), stationDetails['schedule']?['lastTrainTime']),
          SizedBox(width: 20),
          _buildDetailText('빠른하차'.tr(), stationDetails['quickExit']),
        ],
      ),
    );
  }

  String getTranslatedDirection(String originalDirection) {
    Map<String, String> translationMap = {
      '왼쪽': '왼쪽'.tr(), // JSON 파일에서 번역
      '오른쪽': '오른쪽'.tr(),
    };

    return translationMap[originalDirection] ??
        originalDirection; // 번역되지 않으면 원본 반환
  }

  String getTranslatedPlatform(String originalPlatform) {
    Map<String, String> translationMap = {
      '왼쪽': '왼쪽'.tr(), // JSON에서 번역
      '오른쪽': '오른쪽'.tr(),
    };

    return translationMap[originalPlatform] ??
        originalPlatform; // 번역되지 않으면 원본 반환
  }

// 시설 정보
  Widget _buildFacilityInfo(Map<String, dynamic>? facilityInfo) {
    if (facilityInfo == null) return SizedBox();

    return _buildSection(
      title: '시설 정보'.tr(),
      content: Column(
        children: [
          Row(children: [
            _buildDetailText(
              '내리는문'.tr(),
              getTranslatedDirection(facilityInfo['doorSide']), // 번역된 방향 텍스트
            ),
            SizedBox(width: 100),
            _buildDetailText('화장실'.tr(), facilityInfo['restrooms']),
          ]),
          Row(children: [
            _buildDetailText(
              '플랫폼'.tr(),
              getTranslatedPlatform(
                  facilityInfo['platformType']), // 번역된 플랫폼 텍스트
            ),
          ]),
        ],
      ),
    );
  }

// 편의 시설
  Widget _buildConvenienceInfo(Map<String, dynamic>? amenities) {
    if (amenities == null) return SizedBox();

    return _buildSection(
      title: '편의 시설'.tr(),
      content: Column(
        children: [
          Row(children: [
            _buildDetailTextAmenities('편의점 / 카페'.tr(), amenities['store']),
            SizedBox(width: 105),
            _buildDetailTextAmenities('유실물센터'.tr(), amenities['foundCenter']),
          ]),
          Row(
            children: [
              _buildDetailTextAmenities('물품보관소'.tr(), amenities['storageRoom']),
              SizedBox(width: 120),
              _buildDetailTextAmenities('엘리베이터'.tr(), amenities['elevator']),
            ],
          )
        ],
      ),
    );
  }

  String getTranslatedCondition(String originalCondition) {
    Map<String, String> translationMap = {
      '맑음': 'Sunny'.tr(),
      '비': 'Rain'.tr(),
      '눈': 'Snow'.tr(),
      '흐림': 'Cloudy'.tr(),
    };

    return translationMap[originalCondition] ??
        originalCondition; // 번역되지 않으면 원본 반환
  }

// 날씨 정보
  Widget _buildWeatherInfo(Map<String, dynamic>? weatherInfo) {
    if (weatherInfo == null) return SizedBox();

    return _buildSection(
      title: '날씨 정보'.tr(),
      content: Center(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                SizedBox(width: 30),
                Image.asset(
                  'assets/images/locationWeather.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  '${widget.stationName}' + "역".tr(),
                  style: TextStyle(fontSize: 25, color: Color(0xff676363)),
                ),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${weatherInfo['temperature']}' + '°C',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(width: 20),
                        Text(
                          getTranslatedCondition(weatherInfo['condition']),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${'체감온도'.tr()} : ${weatherInfo['perceivedTem'] ?? 'N/A'}°C / ${'습도'.tr()} : ${weatherInfo['humidity'] ?? 'N/A'}%',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                // 날씨 이미지
                SizedBox(width: 20),
                if (weatherInfo['condition'] != null)
                  _buildWeatherImage(weatherInfo['condition']),
              ],
            ),
          ),
        ),
      ),
    );
  }

// 날씨 이미지 빌더
  Widget _buildWeatherImage(String condition) {
    String translatedCondition = getTranslatedCondition(condition);

    if (translatedCondition == 'Sunny') {
      return Image.asset(
        'assets/images/weather/sunny.png',
        width: 30,
        height: 30,
      );
    } else if (translatedCondition == 'Rain') {
      return Image.asset(
        'assets/images/weather/rain.png',
        width: 30,
        height: 30,
      );
    } else if (translatedCondition == 'Snow') {
      return Image.asset(
        'assets/images/weather/snow.png',
        width: 30,
        height: 30,
      );
    } else if (translatedCondition == 'Cloudy') {
      return Image.asset(
        'assets/images/weather/cloud.png',
        width: 30,
        height: 30,
      );
    } else {
      return SizedBox(); // 기본적으로 빈 위젯 반환
    }
  }

// 공통 위젯
  Widget _buildSection({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          content,
          Divider(thickness: 1),
        ],
      ),
    );
  }

// 기본 시설 위젯
  Widget _buildDetailText(String label, String value, {TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$label  ",
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

// 편의시설 위젯
  Widget _buildDetailTextAmenities(String label, bool value) {
    // 조건에 따라 텍스트 스타일 설정
    final textValue = value
        ? TextStyle(color: Colors.black, fontSize: 16) // true일 때
        : TextStyle(
            color: Color.fromARGB(255, 207, 207, 207),
            fontSize: 16); // false일 때

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: "$label  ", // 라벨 텍스트
            style: textValue),
      ),
    );
  }

// 막차 시간 위젯
  Widget _buildDetailText_lastTime(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$label  ",
          style: TextStyle(
              color: const Color.fromARGB(144, 234, 31, 31), fontSize: 16),
          children: [
            TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}

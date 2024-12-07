// 역검색 결과화면

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/FIndWay/WriteStation.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/firebaseUtil.dart';
import 'package:flutter_application_1/util/firebaseGetPrev.dart';
import 'package:easy_localization/easy_localization.dart';
import '../util/util.dart';
import '../constants/lineColor.dart';

import 'package:provider/provider.dart';
import '../constants/displayMode.dart';



class SearchStaInfo extends StatefulWidget {

  final String stationName;

  const SearchStaInfo({Key? key, required this.stationName, required List<Map<String, dynamic>> searchHistory})
      : super(key: key);

  @override
  _SearchStaInfo createState() => _SearchStaInfo();
}

class _SearchStaInfo extends State<SearchStaInfo> {
  late List<Map<String, dynamic>> _searchHistory;
  late Future<Map<String, dynamic>?> stationData;
  bool isFavorite = false;
  late String _favImagePath;

  @override
  void initState() {
    super.initState();
    stationData = fetchStationData(widget.stationName);
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    setState(() {
      _searchHistory = SharedStationData.searchHistory; // SharedStationData에서 최신 데이터 로드
    });
  }  

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
            backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // 특정 조건 (예: 사용자 권한, 페이지 상태 등)
            bool shouldNavigateBack = true; // 원하는 조건으로 설정

            if (shouldNavigateBack) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                print('뒤로가기 실패: 네비게이션 스택에 이전 페이지가 없음'); // 디버깅용 로그
              }
            } else {
              print('뒤로가기 동작이 허용되지 않음'); // 조건에 따라 무시
            }
          },
          child: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text(
          '역 검색',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 60.0,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ).tr(),
        backgroundColor: Color.fromARGB(204, 34, 83, 111),
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
      // 하단바
      bottomNavigationBar: Container(
        height: 60.0, // 높이 조절
        color: const Color.fromARGB(204, 34, 83, 111), // 배경색 설정
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(), // Home()으로 이동
                ),
              );
            },
            child: Image.asset(
              'assets/images/homeLight.png',
              width: 35,
            ),
          ),
        ),
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

  // 각 호선마다 색상 가져오기
  final color = SubwayColors.getColor(stationName.substring(0, 1));
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  
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
          stationName.isNotEmpty
              ? stationName.substring(0, 1)
              : '0',
          style: TextStyle(
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
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  height: 1.5,
                ),
                textAlign: TextAlign.center, // 텍스트를 가운데 정렬
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
  int current = int.parse(widget.stationName);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이템 간 간격 설정
    children: [
      // 이전역
      _buildStationNavigation((current-1).toString(), false),

      // 출발역과 도착역 (클릭시 해당 값과 함께 페이지 이동)
      Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                 MaterialPageRoute(
                      builder: (context) =>
                      WriteStationPage(initialStartStation: widget.stationName, searchHistory: [],)
                    ),           
                                
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
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(width: 10), // 출발역과 도착역 사이 간격
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                 MaterialPageRoute(
                      builder: (context) =>
                      WriteStationPage(initialEndStation: widget.stationName, searchHistory: [],)
                    ),           
                                
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
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),

      // 다음역
      _buildStationNavigation((current+1).toString(), true),
    ],
  );
}

// 이전역 다음역
Widget _buildStationNavigation(String label, bool isNext) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  String displayText = "";
  final number = int.tryParse(label) ?? 0;
  if ((101 <= number && number <= 123) || // 1호선
      (201 <= number && number <= 217) || // 2호선
      (301 <= number && number <= 308) || // 3호선
      (401 <= number && number <= 417) || // 4호선
      (501 <= number && number <= 507) || // 5호선
      (601 <= number && number <= 622) || // 6호선
      (701 <= number && number <= 707) || // 7호선
      (801 <= number && number <= 806) || // 8호선
      (901 <= number && number <= 904)) { // 9호선
    displayText = label; 
  } else {
    displayText = "종점".tr(); 
  }
    return Row(
      children: [
        if (!isNext)
        GestureDetector(
        onTap: () async {
          final result = await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SearchStaInfo(
                stationName: displayText,
                searchHistory: _searchHistory,
              ),
            ),
            (route) => route.isFirst, // 첫 번째 스택만 유지
          );
          if (result != null) {
            // result를 활용한 후 처리
          }
        },
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
        SizedBox(width: 10),
        Text(
          displayText,
          style: TextStyle(
            color: themeNotifier.isDarkMode ? Colors.white : Color(0xff676363),
            fontSize: 16,
          ),
        ),
        if (isNext)
        GestureDetector(
          onTap: () async {
            final result = await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SearchStaInfo(
                  stationName: displayText,
                  searchHistory: _searchHistory,
                ),
              ),
              (route) => route.isFirst, // 첫 번째 스택만 유지
            );
            if (result != null) {
              // result를 활용한 후 처리
            }
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14159), // Y축 회전
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
        ),
      ],
    );
}


// 역 정보
Widget _buildStationInfo(Map<String, dynamic>? stationDetails) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
    if (stationDetails == null) return SizedBox();

    return _buildSection(
      title: '역 정보'.tr(),
      content: Row(
        children: [
          _buildDetailText('배차시간'.tr(), 
          stationDetails['schedule']?['interval'] != null
            ? '${stationDetails['schedule']?['interval']}' + " "+'분'.tr()
            : '정보 없음'),
          SizedBox(width: 20),
          _buildDetailText_lastTime('막차'.tr(), stationDetails['schedule']?['lastTrainTime']),
          SizedBox(width: 50),
          _buildDetailText('빠른하차'.tr(), stationDetails['quickExit']),
        ],
      ),
    );
  }

// 시설 정보
Widget _buildFacilityInfo(Map<String, dynamic>? facilityInfo) {
    if (facilityInfo == null) return SizedBox();

    return _buildSection(
      title: '시설 정보'.tr(),
      content: Column(
        children: [
          Row(children: [
          _buildDetailText('내리는문'.tr(), facilityInfo['doorSide'].toString().tr()),
          SizedBox(width: 100),
          _buildDetailText('화장실'.tr(), facilityInfo['restrooms']),
          ]),
          Row(children: [
            _buildDetailText('플랫폼'.tr(), facilityInfo['platformType'].toString().tr()),
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
            _buildDetailTextAmenities('편의점 / 카페'.tr(),amenities['store']),
            SizedBox(width: 105),
            _buildDetailTextAmenities('유실물센터'.tr(), amenities['foundCenter']),
          ]),
          Row(children: [
          _buildDetailTextAmenities('물품보관소'.tr(), amenities['storageRoom']),
          SizedBox(width: 120),
          _buildDetailTextAmenities('엘리베이터'.tr(), amenities['elevator']),
          ],)
        ],
      ),
    );
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
                '${widget.stationName}' + " "+"역".tr(),
                style: TextStyle(fontSize: 25, color: Color(0xff676363)),
              ),
              SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        '${weatherInfo['temperature']}' + '°C',
                        style: TextStyle(fontSize: 36),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${weatherInfo['condition'].toString().tr()}',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    '체감온도'.tr() +' : ' + '${weatherInfo['perceivedTem']}°C / ' + '습도'.tr()+' : '+'${weatherInfo['humidity']}%',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
              // 날씨 이미지
              SizedBox(width: 30),
              if (weatherInfo['condition'] == "맑음")
                Image.asset(
                  'assets/images/weather/sunny.png', // 맑음 이미지
                  width: 50,
                  height: 50,
                )
              else if (weatherInfo['condition'] == "비")
                Image.asset(
                  'assets/images/weather/rain.png', // 비 이미지
                  width: 50,
                  height: 50,
                )
              else if (weatherInfo['condition'] == "눈")
                Image.asset(
                  'assets/images/weather/snow.png', // 비 이미지
                  width: 50,
                  height: 50,
                )
              else if (weatherInfo['condition'] == "흐림")
                Image.asset(
                  'assets/images/weather/cloud.png', // 비 이미지
                  width: 50,
                  height: 50,
                )
            ],
          ),
        ),
      ),
    ),
  );
}


// 공통 위젯
Widget _buildSection({required String title, required Widget content}) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, 
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black
          )),
          SizedBox(height: 10),
          content,
          Divider(thickness: 1),
        ],
      ),
    );
  }

// 기본 시설 위젯
Widget _buildDetailText(String label, String value, {TextStyle? style}) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: "$label  ",
          style: TextStyle(color: themeNotifier.isDarkMode ? const Color.fromARGB(238, 255, 255, 255) : Colors.black, fontSize: 16),
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
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  // 조건에 따라 텍스트 스타일 설정
  final textValue = value
      ? TextStyle(color: themeNotifier.isDarkMode ? const Color.fromARGB(238, 255, 255, 255) : Colors.black, fontSize: 16) // true일 때
      : TextStyle(color: themeNotifier.isDarkMode ? const Color.fromARGB(240, 173, 173, 173) : Color.fromARGB(255, 207, 207, 207), fontSize: 16); // false일 때

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: "$label  ", // 라벨 텍스트
        style: textValue
      ),
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
          style: TextStyle(color: const Color.fromARGB(144, 234, 31, 31), fontSize: 16),
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
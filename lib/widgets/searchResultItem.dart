import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_application_1/SearchSta/SearchStaInfo.dart';

class SearchResultItem extends StatelessWidget {
  final String stationName;
  final String favImagePath;
  final VoidCallback onToggleFav;
  final VoidCallback onSelect;

  const SearchResultItem({
    Key? key,
    required this.stationName,
    required this.favImagePath,
    required this.onToggleFav,
    required this.onSelect,
  }) : super(key: key);

  // 숫자만 추출하는 함수
  String extractNumber(String input) {
    final RegExp numberRegex = RegExp(r'\d+'); // 숫자에 해당하는 정규식
    final match = numberRegex.firstMatch(input);
    return match?.group(0) ?? ''; // 숫자가 없으면 빈 문자열 반환
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 28,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/subway_small.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                // 글씨 클릭 시 페이지 이동
                onTap: () {
                  final stationNumber = extractNumber(stationName); // 숫자 추출
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchStaInfo(
                        stationName: stationNumber, // 숫자만 전달
                        searchHistory: [],
                      ),
                    ),
                  );
                },
                child: Text(
                  stationName.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF676363),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onToggleFav, // 즐겨찾기 아이콘 클릭
                child: Image.asset(
                  favImagePath,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

// 검색기록결과 위젯
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultItem extends StatelessWidget {
  final String stationName;
  final String favImagePath;
  final VoidCallback onToggleFav;
  final VoidCallback onSelect;

  const SearchResultItem({
    required this.stationName,
    required this.favImagePath,
    required this.onToggleFav,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect, // 검색 기록 항목 클릭 시 동작
      child: Stack(
        children: [
          Padding(
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
                    SizedBox(width: 12),
                    Text(
                      stationName.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF676363),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: onToggleFav,
                      child: Image.asset(
                        favImagePath,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

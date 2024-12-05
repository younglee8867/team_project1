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

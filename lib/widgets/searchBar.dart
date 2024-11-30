// 역 검색바 위젯
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchTopBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onDelete;
  final VoidCallback onMenuTap;

  const SearchTopBar({super.key, 
    required this.controller,
    required this.onSearch,
    required this.onMenuTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color.fromRGBO(0, 57, 115, 148),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onMenuTap,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/menu.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: '역 검색'.tr(),
                      hintStyle: TextStyle(color: Color(0xFFABABAB)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onSubmitted: onSearch,
                    onChanged: (value) {
                      if (value.length == 3) {
                        controller.value = TextEditingValue(
                          text: "$value ",
                        );
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF386B88)),
                  onPressed: () => onSearch(controller.text),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onDelete,
                child: const Text(
                  '검색기록 삭제',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFACACAC),
                  ),
                ).tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
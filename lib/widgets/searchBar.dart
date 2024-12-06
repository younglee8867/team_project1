// 역 검색바 위젯
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: themeNotifier.isDarkMode ? const Color.fromARGB(179, 211, 211, 211) : Colors.white,
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
                      hintStyle: TextStyle(color: themeNotifier.isDarkMode ? const Color.fromARGB(217, 31, 31, 31) : Color(0xFFABABAB)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onSubmitted: (value) {
                      if (value.length == 3) {
                        final number = int.tryParse(value) ?? 0;

                        // 유효한 범위인지 확인
                        if ((101 <= number && number <= 123) || // 1호선
                            (201 <= number && number <= 217) || // 2호선
                            (301 <= number && number <= 308) || // 3호선
                            (401 <= number && number <= 417) || // 4호선
                            (501 <= number && number <= 507) || // 5호선
                            (601 <= number && number <= 622) || // 6호선
                            (701 <= number && number <= 707) || // 7호선
                            (801 <= number && number <= 806) || // 8호선
                            (901 <= number && number <= 904)) { // 9호선
                          onSearch?.call("$value");
                        } else {
                          // 잘못된 값일 경우 초기화 및 경고 메시지 표시
                          controller.clear();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("오류"),
                              content: Text("유효하지 않은 역 번호입니다."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("확인"),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // 입력이 3자리가 아닐 경우 경고 메시지 표시
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("오류"),
                            content: Text("숫자 세 자리를 입력해주세요."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("확인"),
                              ),
                            ],
                          ),
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
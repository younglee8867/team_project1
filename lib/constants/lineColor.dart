// 색상코드(1~9호선)
import 'package:flutter/material.dart';

class SubwayColors {
  static const Map<String, Color> colors = {
    "1": Color(0xff0E309D),
    "2": Color(0xff17B141),
    "3": Color(0xffFC4C13),
    "4": Color(0xff05ABDD),
    "5": Color(0xff9F5FB2),
    "6": Color(0xffA94322),
    "7": Color(0xff69813B),
    "8": Color(0xffE41A79),
    "9": Color(0xff8D827A),
  };

  static Color getColor(String line) {
    return colors[line] ?? const Color.fromARGB(255, 0, 0, 0); // 기본값은 회색
  }
}

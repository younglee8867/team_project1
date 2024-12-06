import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

// 테마 데이터
final Map<int, Color> colorMap = {
  50: const Color(0xffe4f4f6),
  100: const Color(0xffc9e9ec),
  200: const Color(0xffaedde3),
  300: const Color(0xff93d2d9),
  400: const Color(0xff78c6cf),
  500: const Color(0xff5cbac5),
  600: const Color(0xff3fafbc),
  700: const Color(0xff33a3b3),
  800: const Color(0xff2787a4),
  900: const Color(0xff1b6b84),
};

final MaterialColor customSwatch = MaterialColor(0xff397394, colorMap);

final ThemeData lightTheme = ThemeData(
  primarySwatch: customSwatch,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, // 라이트 모드 배경: 흰색

);

final ThemeData darkTheme = ThemeData(
  primarySwatch: customSwatch,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 91, 91, 91), // 부드러운 다크 배경

);

// 테마모드 관리 클래스
class ThemeNotifier extends ChangeNotifier {
  late ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._isDarkMode) {
    _currentTheme = _isDarkMode ? darkTheme : lightTheme;
  }

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }
}
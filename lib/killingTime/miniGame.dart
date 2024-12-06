import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import '../constants/displayMode.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppleGame(),
    );
  }
}

class AppleGame extends StatefulWidget {
  @override
  _AppleGameState createState() => _AppleGameState();
}

class _AppleGameState extends State<AppleGame> {
  late AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  List<Apple> _apples = []; // 사과 리스트
  List<Apple> _selectedApples = []; // 선택된 사과 리스트
  int _score = 0; // 점수
  bool _isGameOver = false; // 게임 종료 여부
  late Timer _timer; // 타이머
  int _timeLeft = 30; // 남은 시간 (초)
  bool _applesGenerated = false; // 사과 생성 여부 확인
  final int _maxTime = 30;

  double _lastWidth = 0;
  double _lastHeight = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
        _assetsAudioPlayer.open(
      Audio("assets/appleGame.mp3"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      autoStart: false, //자동 시작 여부
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
        );
    _assetsAudioPlayer.play(); //재생
    _assetsAudioPlayer.pause(); //멈춤
    _assetsAudioPlayer.stop(); //정지
  }



  // 사과 생성 함수
 void _generateApples(double width, double height) {
    Random rand = Random();
    _apples.clear();

    const double padding = 11.0; // 사과 간 간격
    const double appleSize = 50.0; // 사과 크기
    final double usableWidth = width; 
    final double usableHeight = height; 

    final int columns = (usableWidth / (appleSize + padding)).floor() +1; // 가로 열 수
    final int rows = (usableHeight / (appleSize + padding)).floor(); // 세로 행 수

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        _apples.add(Apple(
          x: j * (appleSize + padding), // 가로 정렬
          y: i * (appleSize + padding), // 세로 정렬
          number: rand.nextInt(9) + 1, // 사과는 1~9 숫자를 가짐
        ));
      }
    }
    _applesGenerated = true;
  }


  // 타이머 시작 함수
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        _endGame();
        _timer?.cancel(); // 타이머 종료
      } else {
        if (mounted) { // 위젯이 여전히 트리에 존재하는지 확인
          setState(() {
            _timeLeft--;
          });
        }
      }
    });
  }

  // 게임 종료 처리
  void _endGame() {
    _timer.cancel();
    setState(() {
      _isGameOver = true;
    });
  }

  // 사과 합산 후 10이 되면 삭제
  void _checkForMatch() {
    int total = 0;
    for (Apple apple in _selectedApples) {
      total += apple.number;
    }

    if (total == 10) {
      setState(() {
        _score += 10;
        _apples.removeWhere((apple) => _selectedApples.contains(apple));
        _selectedApples.clear();
      });
    } else {
      // 선택한 두 사과의 합이 10이 아니면 초기화
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _selectedApples.clear();
        });
      });
    }
  }

  // 사과 위젯 만들기
  Widget _buildApple(Apple apple) {
    bool isSelected = _selectedApples.contains(apple);
    return Positioned(
      left: apple.x,
      top: apple.y,
      child: GestureDetector(
        onTap: () {
          _onAppleSelected(apple);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 50,
          height: 62,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/miniGame/apple.png'),
              fit: BoxFit.cover,
            ),
            border: isSelected
                ? Border.all(color: Colors.red, width: 3) // 선택된 사과 테두리 표시
                : null,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    apple.number.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 사과를 선택하는 기능
  void _onAppleSelected(Apple apple) {
    if (_selectedApples.length < 2) {
      setState(() {
        if (_selectedApples.contains(apple)) {
          _selectedApples.remove(apple);
        } else {
          _selectedApples.add(apple);
        }
      });

      // 두 개의 사과를 선택한 후 합산을 체크
      if (_selectedApples.length == 2) {
        _checkForMatch();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
        backgroundColor: themeNotifier.isDarkMode
          ? const Color.fromARGB(255, 38, 38, 38) // 다크 모드 배경
          : Colors.white,
      appBar: AppBar(
          backgroundColor: themeNotifier.isDarkMode
            ? Color.fromARGB(255, 38, 38, 38) // 다크 모드 색상
            : const Color.fromARGB(255, 255, 255, 255), // 라이트 모드 색상
      leading: GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
        child: Icon(Icons.arrow_back, color: themeNotifier.isDarkMode? const Color.fromARGB(255, 255, 255, 255): Color(0xff978080)),
      ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // 이미지 간 간격
            child: GestureDetector(
               onTap: (() async {
                //await audioPlayer.play(AssetSource('assets/sound/appleGame.ogg'));
                print("click!!!!!!!!!!!!!!!!!!!!!!!!!!!");
              }),
              child: Image.asset(
              'assets/images/miniGame/gameMusic.png',
              height: 30,
              width: 30,
              
            ),
            ) 

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // 이미지 간 간격
            child: Image.asset(
              'assets/images/miniGame/gameInfo.png',
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
 body: Padding(
      padding: const EdgeInsets.all(20.0), // 전체 화면에 패딩 추가
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 점수 표시
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // 아래 간격 추가
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: themeNotifier.isDarkMode? const Color.fromARGB(255, 226, 226, 226): Color(0xff978080),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Score: $_score',
                style: TextStyle(fontSize: 30, color: themeNotifier.isDarkMode? Color(0xff978080): Color.fromARGB(255, 226, 226, 226),),
              ),
            ),
          ),

          // 타이머
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                // 남은 시간 표시
                Padding(
                  padding: const EdgeInsets.only(right: 10.0), // 텍스트와 바 사이 간격
                  child: Text(
                    'Time: $_timeLeft',
                    style: TextStyle(fontSize: 24, color: themeNotifier.isDarkMode? const Color.fromARGB(255, 226, 226, 226): Color(0xff978080)),
                  ),
                ),
                // 가로선 타이머
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            width: (constraints.maxWidth * (_timeLeft / _maxTime)).clamp(0, constraints.maxWidth),
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 20), // 타이머와 사과 영역 사이 간격

          // 사과 영역
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;

                // 화면 크기가 변경될 때만 사과를 다시 생성
                if (_lastWidth != screenWidth || _lastHeight != screenHeight) {
                  _lastWidth = screenWidth;
                  _lastHeight = screenHeight;
                  _generateApples(screenWidth, screenHeight);
                }

                return Stack(
                  children: [
                    // 사과들 그리기
                    for (Apple apple in _apples) _buildApple(apple),
                    // 게임 종료 메시지
                    if (_isGameOver)
                      Center(
                        child: AlertDialog(
                          title: Text('Game Over'),
                          content: Text('Score: $_score'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _score = 0;
                                  _isGameOver = false;
                                  _timeLeft = 30;
                                  _generateApples(screenWidth, screenHeight);
                                  _startTimer();
                                });
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
 )
    );
  }
}


// 사과 클래스 정의
class Apple {
  double x;
  double y;
  int number;

  Apple({
    required this.x,
    required this.y,
    required this.number,
  });
}

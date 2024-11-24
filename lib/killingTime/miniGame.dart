// 11.24 게임 디테일 수정(잘못 클릭하면 아예 다음것도 안됨)
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '사과 게임',
      home: AppleGame(),
    );
  }
}

class AppleGame extends StatefulWidget {
  @override
  _AppleGameState createState() => _AppleGameState();
}

class _AppleGameState extends State<AppleGame> {
  List<Apple> _apples = []; // 사과 리스트
  List<Apple> _selectedApples = []; // 선택된 사과 리스트
  int _score = 0; // 점수
  bool _isGameOver = false; // 게임 종료 여부
  late Timer _timer; // 타이머
  int _timeLeft = 30; // 남은 시간 (초)

  @override
  void initState() {
    super.initState();
    _generateApples();
    _startTimer();
  }

  // 사과 생성 함수
  void _generateApples() {
    Random rand = Random();
    _apples.clear();
    const double padding = 10.0; // 사과 간 간격
    const double appleSize = 50.0; // 사과 크기
    const int columns = 8; // 가로 열 수
    const int rows = 17; // 세로 행 수

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        _apples.add(Apple(
          x: j * (appleSize + padding), // 가로 정렬
          y: i * (appleSize + padding), // 세로 정렬
          number: rand.nextInt(9) + 1, // 사과는 1~9 숫자를 가짐
        ));
      }
    }
  }

  // 타이머 시작 함수
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        _endGame();
      } else {
        setState(() {
          _timeLeft--;
        });
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
    }
  }

  // 사과 위젯 만들기
  Widget _buildApple(Apple apple) {
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
            image: AssetImage('../assets/images/miniGame/apple.png'), // 사과 이미지 경로
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 이미지 위에 텍스트 표시
            Positioned(
              top: 20, // 텍스트를 10만큼 아래로 이동
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
    if (_selectedApples.contains(apple)) {
      _selectedApples.remove(apple);
    } else {
      _selectedApples.add(apple);
    }
    _checkForMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.arrow_back, color: Color(0xff22536F)),
        ),
        title: Text(
          "사과 게임",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff22536F),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          if (_isGameOver) {
            setState(() {
              _score = 0;
              _isGameOver = false;
              _timeLeft = 30;
              _generateApples();
              _startTimer();
            });
          }
        },
        child: Stack(
          children: [
            // 배경
            Container(color: const Color.fromARGB(255, 255, 255, 255)),

            // 사과들 그리기
            for (Apple apple in _apples) _buildApple(apple),

          // 점수 표시
          Positioned(
            top: 80,
            right: 20,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 120, 158, 225), // 배경 색상
                borderRadius: BorderRadius.circular(12), // 둥근 모서리
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Score: $_score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),


          // 남은 시간 표시
          Positioned(
            top: 20,
            right: 20,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 225, 152, 92), // 배경 색상
                borderRadius: BorderRadius.circular(12), // 둥근 모서리
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Time: $_timeLeft',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

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
                          _generateApples();
                          _startTimer();
                        });
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
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

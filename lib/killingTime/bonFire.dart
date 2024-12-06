import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BonFire extends StatefulWidget {
  @override
  _BonFire createState() => _BonFire();
}

class _BonFire extends State<BonFire> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;


  // 오디오 재생
  void _play() async{
    if(isPlaying){
      await audioPlayer.pause();
    }else{
      await audioPlayer.play('bonFire.mp3' as Source);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _stop() async{
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 GIF
          Container(
            width: double.infinity, // 화면 가로 전체
            height: double.infinity, // 화면 세로 전체
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover, // GIF가 화면을 꽉 채우도록
                image: AssetImage('assets/images/miniGame/bonFireAnimated.gif'),
              ),
            ),
          ),
          IconButton(
            onPressed: _play, 
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          ),

          // 뒤로가기 버튼
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),

          // 텍스트 표시
          Positioned(
            top: 100,
            left: 100,
            child: Text(
              'r e l a x i n g. . . ',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

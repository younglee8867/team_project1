import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(AnimalFarm());

class AnimalFarm extends StatelessWidget {
  static List animalList = ['cat', 'dog', 'pig', 'owl', 'tiger'];

  final AudioPlayer _audioPlayer = AudioPlayer();

  Expanded animalButton(String animal) {
    return Expanded(
      child: IconButton(
        onPressed: () async {
        try {
          await _audioPlayer.play(AssetSource('appleGame.ogg'));
        } catch (e) {
          print('OGG failed, trying MP3: $e');
          try {
            await _audioPlayer.play(AssetSource('appleGame.mp3'));
          } catch (e) {
            print('Both formats failed: $e');
          }
        }
        },
        icon: Image.asset(
          'images/splashLogo.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var v in animalList) animalButton(v),
            ],
          ),
        ),
      ),
    );
  }
}

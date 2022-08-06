import 'package:flutter/material.dart';
import 'package:musik/lyricsMessage.dart';

class EmotionalLyrics extends StatefulWidget {
  const EmotionalLyrics({Key? key}) : super(key: key);

  @override
  State<EmotionalLyrics> createState() => _EmotionalLyricsState();
}

class _EmotionalLyricsState extends State<EmotionalLyrics> {
  late String emotion;
  late String lyrics_result;
  late String images;
  late String emotion_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 유저가 선택한 감정
    emotion = lyrics.emotion;
    // 작사 결과값
    lyrics_result = lyrics.lyric;

    setState(() {
      if (emotion == 'happy') {
        emotion_name = '행복';
        images = "images/joy.png";
      } else if (emotion == 'sad') {
        emotion_name = '슬픔';
        images = "images/sad.png";
      } else {
        emotion_name = '무무';
        images = "images/dumdum.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('뮤식이의 AI 작사'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              images,
              width: 100,
              height: 90,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$emotion_name",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Color.fromARGB(255, 252, 199, 9),
                  ),
                ),
                const Text(
                  '의 감정으로 만들었어요',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(lyrics_result),
            const SizedBox(
              height: 25,
            ),
            const Text(
              '뮤식이의 추천 플레이리스트는 어때요?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 30),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const DiaryAdd(); // 음악 추천 페이지로
                //     },
                //   ),
                // );
              },
              child: const Text(
                '뮤식이의 음악추천',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

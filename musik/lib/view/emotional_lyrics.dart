import 'package:flutter/material.dart';
import 'package:musik/lyricsMessage.dart';
import 'package:musik/view/playlist.dart';

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
  late String color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 유저가 선택한 감정
    emotion = Lyrics.emotion;
    // 작사 결과값
    lyrics_result = "";

    color = "";

    setState(() {
      lyrics_result = Lyrics.lyric;
      if (emotion == '기쁨') {
        emotion_name = '기쁨';
        images = "images/joy.png";
        color = 'red';
      } else if (emotion == '슬픔') {
        emotion_name = '슬픔';
        color = 'blue';
        images = "images/sad.png";
      } else {
        emotion_name = '무무';
        images = "images/dumdum.png";
        color = "amber";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('뮤식이의 AI 작사'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              images,
              width: 100,
              height: 90,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$emotion_name",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: emotion_name == "기쁨"
                          ? Colors.red
                          : emotion_name == '슬픔'
                              ? Colors.blue
                              : Colors.amber),
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
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 5, 60, 20),
              child: Text(
                "$lyrics_result.",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              '뮤식이의 추천 플레이리스트는 어때요?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
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
                // Navigator.pushNamed(context, '/playlist');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Playlist(); // 음악 추천 페이지로
                    },
                  ),
                );
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

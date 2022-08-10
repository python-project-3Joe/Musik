import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musik/lyricsMessage.dart';

class SelectEmotion extends StatefulWidget {
  const SelectEmotion({Key? key}) : super(key: key);

  @override
  State<SelectEmotion> createState() => _SelectEmotionState();
}

class _SelectEmotionState extends State<SelectEmotion> {
  // happy, sad, Indifference
  late String emotion; // 감정값
  late String emotionPath;
  late String result; // 작사 결과값

  @override
  void initState() {
    super.initState();
    emotion = "";
    emotionPath = '';
    result = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Music AI Lyricist'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'AI 뮤직 작사가',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Color.fromARGB(255, 252, 199, 9),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '감정을 선택하면 뮤식이가 작사를 해드려요!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        emotionPath = 'images/joy.png';
                        emotion = '기쁨';
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'images/joy.png',
                          width: 80,
                          height: 90,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // 이미지 이름
                          '기쁨',
                          style: emotion == '기쁨'
                              ? const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)
                              : const TextStyle(
                                  color: Colors.black,
                                ), /*enameEdit*/
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        emotionPath = 'images/dumdum.png';
                        emotion = '무무';
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'images/dumdum.png',
                          width: 80,
                          height: 90,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // 이미지 이름
                          '무무',
                          style: emotion == '무무'
                              ? const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold)
                              : const TextStyle(
                                  color: Colors.black,
                                ), /*enameEdit*/
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        emotionPath = 'images/sad.png';
                        emotion = '슬픔';
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'images/sad.png',
                          width: 80,
                          height: 90,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // 이미지 이름
                          '슬픔',
                          style: emotion == '슬픔'
                              ? const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold)
                              : const TextStyle(
                                  color: Colors.black,
                                ), /*enameEdit*/
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(210, 45),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                emotion;
                getJSONData();
                Navigator.pushNamed(context, '/Splashscreen_lyrics');
              },
              label: const Text(
                '작사 시작',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              icon: const Icon(
                Icons.music_note,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function

  void getJSONData() async {
    var url = Uri.parse('http://127.0.0.1:5000//markov?emotion=$emotion');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      Lyrics.emotion = emotion;
      print(result);
      Lyrics.lyric = result;
    });
  }
}// end
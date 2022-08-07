import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musik/view/diaryadd.dart';

class DiaryHome extends StatefulWidget {
  const DiaryHome({Key? key}) : super(key: key);

  @override
  State<DiaryHome> createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHome> {
  late String emotion;
  late String emotionPath;

  @override
  void initState() {
    super.initState();
    emotion = '';
    emotionPath = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/musik.png',
              width: 100,
              height: 90,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '감정 기록하기',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('나의 감정을 기록하면\n뮤식이가 감정을 분석해서\n음악을 추천해줘요'),
            const SizedBox(
              height: 20,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DiaryAdd(); // Map으로 보내
                    },
                  ),
                );
              },
              child: const Text(
                '기록하기',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              'AI 뮤직 작사가',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('감정을 선택하면 뮤식이가 작사를 해드려요'),
            const SizedBox(
              height: 20,
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
                                  color: Colors.green,
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
                                  color: Colors.green,
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
                                  color: Colors.green,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30),
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/selectEmotion');
                  },
                  child: const Text(
                    '작사 하기',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

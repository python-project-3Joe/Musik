import 'package:flutter/material.dart';

class SelectEmotion extends StatefulWidget {
  const SelectEmotion({Key? key}) : super(key: key);

  @override
  State<SelectEmotion> createState() => _SelectEmotionState();
}

class _SelectEmotionState extends State<SelectEmotion> {
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
            Text(
              'AI 뮤직 작사가',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color.fromARGB(255, 252, 199, 9),
              ),
            ),
            const Text(
              '감정을 선택하면 뮤식이가 작사를 해드려요',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 15,
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(280, 50),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                //
              },
              child: const Text(
                '작사 시작',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

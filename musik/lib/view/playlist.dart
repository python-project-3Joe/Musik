import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}



class _PlaylistState extends State<Playlist> {
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
      appBar:  AppBar(
        title: const Text(
          '감정 플레이리스트',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
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
                                height: 80,
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                height: 80,
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                                height: 80,
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
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, '/video');
                      }),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  // 이미지 url
                                  "https://cdnimg.melon.co.kr/cm2/album/images/108/16/959/10816959_20211217144957_500.jpg?c1818ddc493cb2bbb4d268431e6de7b5/melon/resize/282/quality/80/optimize",   
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("사랑인가봐") // 노래 제목
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Text("멜로망스") // 가수 이름
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("2022.07.22")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
              
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:musik/lyricsMessage.dart';

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
  late List musicList;

  // 페이지네이션 처리
  late int page;

  @override
  void initState() {
    super.initState();
    emotion = "";
    emotionPath = '';
    result = '';
    musicList = [];
    page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '감정 플레이리스트',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                        page = 0;
                        emotionPath = 'images/joy.png';
                        emotion = 'happy';
                        // 기쁨 listdata 가져오기
                        getJSONData();
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
                        // 항상 첫페이지 부터 나오게하기
                        page = 0;
                        emotionPath = 'images/dumdum.png';
                        emotion = 'indifference';
                        // 덤덤 listdata 가져오기
                        getJSONData();
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
                        page = 0;
                        emotionPath = 'images/sad.png';
                        emotion = 'sad';
                        // 슬픔 listdata 가져오기
                        getJSONData();
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
            Container(
              width: 400,
              height: 700,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: musicList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      getJSONData();
                      setState(() {
                        page += 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: Expanded(
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              Lyrics.lyric = musicList[index]['m_lycrics'];
                              Lyrics.mimage = musicList[index]['m_image'];
                              Lyrics.msinger = musicList[index]['m_singer'];
                              Lyrics.mtitle = musicList[index]['m_title'];
                              Lyrics.mlink = musicList[index]['m_link'];
                              Lyrics.date = musicList[index]['m_date'];
                            });
                            Navigator.pushNamed(context, '/songDetail');
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      // 이미지 url
                                      musicList[index]['m_image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(musicList[index]['m_title']
                                                    .length >
                                                20
                                            ? '${musicList[index]['m_title'].substring(0, 20)}...'
                                            : musicList[index]
                                                ['m_title']) // 노래 제목
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(musicList[index]
                                            ['m_singer']) // 가수 이름
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  // Function
  Future<bool> getJSONData() async {
    musicList = []; // 초기화
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/daily_musicList.jsp?emotion=$emotion&page=$page');

    var response = await http.get(url); // 빌드가 끝날 때까지 기다려
    var dataConvertedJSON =
        json.decode(utf8.decode(response.bodyBytes)); // 한글깨짐방지, map방식으로 변환

    List result = dataConvertedJSON['results'];

    setState(() {
      musicList.addAll(result);
    });
    print(musicList);
    return true;
  }
}

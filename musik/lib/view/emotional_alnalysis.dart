import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:musik/diaryMessage.dart';
import 'package:musik/lyricsMessage.dart';
import 'package:musik/userMessage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class EmotionalAnalysis extends StatefulWidget {
  const EmotionalAnalysis({Key? key}) : super(key: key);

  @override
  State<EmotionalAnalysis> createState() => _EmotionalAnalysisState();
}

class _EmotionalAnalysisState extends State<EmotionalAnalysis> {
  late String result;
  late double negative;
  late double neutral;
  late double positive;
  late String uid;
  late String dtitle;
  late Map<String, double> dataMap;
  late String images;
  late String emotion;

  @override
  void initState() {
    super.initState();
    dtitle = diary.dtitle;
    result = diary.result;
    negative = double.parse(diary.negative);
    neutral = double.parse(diary.neutral);
    positive = double.parse(diary.positive);
    uid = User.uId;
    emotion = "";
    Map<String, double> dataMap = {};

    // setState(() {

    // });
    setState(() {
      if (result == "positive") {
        result = "기쁨";
        emotion = 'happy';
        images = "images/joy.png";
      } else if (result == "neutral") {
        result = "무관심";
        images = "images/dumdum.png";
        emotion = "Indifference";
      } else {
        result = "슬픔";
        images = "images/sad.png";
        emotion = 'sad';
      }
    });
  }

  // Map<String, double> dataMap = {
  //   "기쁨": 50.0,
  //   "무관심": 25.1,
  //   "슬픔": 24.9,
  // };

  final colorList = <Color>[
    Color.fromARGB(255, 214, 69, 58),
    Color.fromARGB(255, 252, 199, 9),
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('감정 분석 결과'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                '뮤식이가 분석한 결과',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              children: [
                Image.asset(
                  images,
                  width: 100,
                  height: 90,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '" ',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$dtitle',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color.fromARGB(255, 5, 152, 0)),
                    ),
                    Text(
                      ' "의 일기 감정은',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$result",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: result == "기쁨"
                            ? Color.fromARGB(255, 214, 69, 58)
                            : result == "무관심"
                                ? Color.fromARGB(255, 252, 199, 9)
                                : Colors.blueAccent,
                      ),
                    ),
                    Text(
                      ' 으로 보여져요',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            PieChart(
              dataMap: dataMap = {
                "기쁨": double.parse(diary.positive),
                "무관심": double.parse(diary.neutral),
                "슬픔": double.parse(diary.negative),
              },
              animationDuration: Duration(milliseconds: 900),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 10,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              // centerText: "Musik",
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    '뮤식이의 두둠칫',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // fixedSize: const Size(280, 50),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      emotion;
                      getJSONData();
                    },
                    child: const Text(
                      '뮤식이의 AI 작사',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // fixedSize: const Size(280, 50),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //
                    },
                    child: const Text(
                      '뮤식이의 음악추천',
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
          ],
        ),
      ),
    );
  }

  void getJSONData() async {
    var url = Uri.parse('http://127.0.0.1:5010//markov?emotion=$emotion');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      lyrics.emotion = emotion;
      print(result);
      lyrics.lyric = result;
      Navigator.pushNamed(context, '/Splashscreen_lyrics');
    });
  }
}

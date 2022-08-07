import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musik/userMessage.dart';

class DiaryAdd extends StatefulWidget {
  const DiaryAdd({Key? key}) : super(key: key);

  @override
  State<DiaryAdd> createState() => _DiaryAddState();
}

class _DiaryAddState extends State<DiaryAdd> {
  // 타이틀, 내용, 이모지 사진경로, 이모지 이름
  late String emotion; // emoji
  late String emotionPath; //epath
  late TextEditingController titleEdit; // d_title
  late TextEditingController contentEdit; //d_content
  late String dtitle;
  late String dcontent;
  late String result;
  late String uid;

  @override
  void initState() {
    super.initState();

    titleEdit = TextEditingController();
    contentEdit = TextEditingController();
    emotion = "";
    emotionPath = "";
    dtitle = "";
    dcontent = "";
    result = "";
    uid = User.uId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Mood'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.brown,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.brown[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // 기분 상태 아이콘
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
                              width: 100,
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
                              width: 100,
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
                              width: 100,
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
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // title
                  TextField(
                    controller: titleEdit,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.brown),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // content
                  TextField(
                    controller: contentEdit,
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.brown),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 30),
                primary: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                  dtitle = titleEdit.text;
                  dcontent = contentEdit.text;
                  insertAction();
                  getJSONData();// 데이터저장
              },
              child: const Text(
                'AI 감정 분석',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
        ]),
      ),
    );
  }

  insertAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/daily_add.jsp?dtitle=$dtitle&dcontent=$dcontent&demoji=$emotion&uid=$uid');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      if (result == 'OK') {
        _showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }
// 일기 문장을 가지고 upload_bayes_app.py로 들어가게 됨
  void getJSONData() async {
    var url = Uri.parse(
        'http://127.0.0.1:5000/bayes?&dcontent=$dcontent');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      // print(result);
    });
  }  
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Icon(Icons.check_circle_rounded),
            content: const Text('등록이 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 입력에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}

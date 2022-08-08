import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musik/diaryMessage.dart';
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
  late String negative;
  late String neutral;
  late String positive;

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
    negative = "";
    neutral = "";
    positive = "";
    uid = User.uId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Emotion Diary'),
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
          SingleChildScrollView(
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
                            width: emotion == '기쁨' ? 110 : 100,
                            height: emotion == '기쁨' ? 95 : 90,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            // 이미지 이름
                            '기쁨',
                            style: emotion == '기쁨'
                                ? const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900)
                                : const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900
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
                            width: emotion == '무무' ? 110 : 100,
                            height: emotion == '무무' ? 95 : 90,
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
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900)
                                : const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800
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
                            
                            width: emotion == '슬픔' ? 110 : 100,
                            height: emotion == '슬픔' ? 95 : 90,
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
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900)
                                : const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900
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
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 350,
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
                      hintText: '일기 제목을 적어주세요.',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(147, 203, 183, 70),
                        ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Color.fromARGB(147, 203, 183, 70)),
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
                  SingleChildScrollView(
                    child: TextField(
                      controller: contentEdit,
                      keyboardType: TextInputType.text,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: '당신의 감정을 적어주세요.',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(147, 203, 183, 70),
                          ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Color.fromARGB(147, 203, 183, 70)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.brown),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
              Navigator.pushNamed(context, '/Splashscreen_diary');
              getJSONData(); // 데이터저장
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
    var url = Uri.parse('http://127.0.0.1:5000/bayes?diary=$dcontent');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));

      result = dataConvertedJSON['result'];
      negative = dataConvertedJSON['negative'];
      positive = dataConvertedJSON['positive'];
      neutral = dataConvertedJSON['neutral'];
      print(result);
      print(positive);
      print(neutral);
      print(negative);
      
      diary.dtitle = dtitle;
      diary.result = result;
      diary.positive = positive;
      diary.neutral = neutral;
      diary.negative = negative;
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiaryContent extends StatefulWidget {
  final Map diaryList;
  const DiaryContent({Key? key, required this.diaryList}) : super(key: key);

  @override
  State<DiaryContent> createState() => _DiaryContentState();
}

class _DiaryContentState extends State<DiaryContent> {
  // d_id, d_title, d_content, d_emoji, u_id,
  late String emotionPath;
  late TextEditingController titleEdit; // title
  late TextEditingController contentEdit; // content
  late int did; // diary
  late String emotion; // emotion
  late String dtitle;
  late String dcontent; // diary Json에 사용
  late String result;

  @override
  void initState() {
    super.initState();
    emotionPath = '';
    titleEdit = TextEditingController();
    contentEdit = TextEditingController();
    dtitle = '';
    dcontent = '';
    titleEdit.text = widget.diaryList['d_title'];
    contentEdit.text = widget.diaryList['d_content'];
    did = widget.diaryList['d_id'];
    emotion = widget.diaryList['d_emoji'];
    result = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'My Mood',
        ),
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
                                    fontWeight: FontWeight.w900), /*enameEdit*/
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
                                    fontWeight: FontWeight.w800), /*enameEdit*/
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
                                    fontWeight: FontWeight.w900), /*enameEdit*/
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
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(147, 203, 183, 70)),
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
                          borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(147, 203, 183, 70)),
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
              updateAction();
              // 데이터저장
            },
            child: const Text(
              '수정하기',
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

  //---function

  // 수정 의사 확인 알림창
  _editShowDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Icon(
            Icons.edit_note_rounded,
            color: Colors.amber,
          ),
          content: const Text('            수정하시겠습니까?'),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // print('$content , $eid , $did');
                      Navigator.of(ctx).pop();
                      updateAction();
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

// 수정 JSON
  Future<String> updateAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/daily_update.jsp?dtitle=$dtitle&dcontent=$dcontent&demotion=$emotion&did=$did');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    result = dataConvertedJSON['result'];

    //print(result);

    setState(() {
      if (result == 'OK') {
        _showfinishDialog(context);
      } else {
        editerrorSnackBar(context);
      }
    });

    return result;
  }

// 수정 완료 후 List로 pop
  _showfinishDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Icon(
              Icons.task_alt,
              color: Colors.amber,
            ),
            content: const Text('         수정이 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: const Center(child: Text('확인')),
              ),
            ],
          );
        });
  }

// 수정 실패 시 에러바
  editerrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('수정에 실패하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  } // error

//-------------------------------------------

// 삭제 의사 확인 알림창
  _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.red,
              size: 30,
            ),
            content: const Text('            삭제하시겠습니까?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      deleteAction();
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
            ],
          );
        });
  }

// 삭제 JSON
  Future<String> deleteAction() async {
    var url =
        Uri.parse('http://localhost:8080/Flutter/daily_delete.jsp?did=$did');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    result = dataConvertedJSON['result'];

    setState(() {
      if (result == 'OK') {
        _deleteFinishDialog(context);
      } else {
        deleteerrorSnackBar(context);
      }
    });
    return result;
  }

// 삭제 완료 후 확인창
  _deleteFinishDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Icon(
              Icons.task_alt,
              color: Colors.red,
              size: 30,
            ),
            content: const Text('          삭제가 완료 되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  }

// 삭제 실패 에러바
  deleteerrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('데이터 삭제에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
} // end

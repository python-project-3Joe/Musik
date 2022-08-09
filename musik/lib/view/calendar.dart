import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musik/userMessage.dart';
import 'package:musik/view/diarycontent.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //property
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  late String uId;
  late String uNickname;

  late List diaryList;

  @override
  void initState() {
    super.initState();

    // uId = "aaa";
    // uNickname = "가슬";
    uId = User.uId;
    uNickname = User.uNickname;
    diaryList = [];
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('$uNickname 님\n 감정 캘린더'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        uNickname,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 247, 201, 32),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '님',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '감정 캘린더',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            //calendar
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TableCalendar(
                    locale: 'ko-KR',
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    focusedDay: selectedDay,
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },

                    // Day Changed
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay =
                            focusDay; // update `_focusedDay` here as well
                        // cDate = selectedDay.toString().substring(0, 10);
                      });
                      // getJSONData();
                    },

                    selectedDayPredicate: (DateTime day) {
                      return isSameDay(selectedDay, day);
                    },

                    eventLoader: (day) {
                      List dot = [];

                      for (int i = 0; i < diaryList.length; i++) {
                        if (diaryList.isNotEmpty) {
                          if (day.toString().substring(0, 10) ==
                              diaryList[i]['d_date']
                                  .toString()
                                  .substring(0, 10)) {
                            dot.add(true);
                          }
                        }
                      }
                      // for (int a = 0; a < allAnalysisData.length; a++) {
                      //   if (allAnalysisData.isNotEmpty) {
                      //     if (day.toString().substring(0, 10) ==
                      //         allAnalysisData[a]['bDate']) {
                      //       dot.add(true);
                      //     }
                      //   }
                      // }
                      return dot;
                    },

                    // Calendar Style
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.amberAccent,
                        shape: BoxShape.rectangle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color.fromARGB(137, 255, 214, 64),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonShowsNext: false,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: diaryList.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          '작성된 일기가 없습니다. \n\n 일기를  작성해주세요!',
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: diaryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DiaryContent(
                                      diaryList: diaryList[index]); // Map으로 보내
                                },
                              )).then((value) => getJSONData());
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.4), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 2, // blur radius
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(17, 0, 15, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${diaryList[index]['d_date'].substring(6, 7)}월 ${diaryList[index]['d_date'].substring(8, 10)}일'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${diaryList[index]['d_title']}:',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          diaryList[index]['d_content'],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        diaryList[index]['d_emoji'] == '기쁨'
                                            ? Image.asset(
                                                'images/joy.png',
                                                width: 30,
                                                height: 30,
                                              )
                                            : Image.asset(
                                                'images/sad.png',
                                                width: 30,
                                                height: 30,
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }

// Function
  Future<bool> getJSONData() async {
    diaryList = []; // 초기화
    var url = Uri.parse(
        'http://localhost:8080/Flutter/musik/daily_list_flutter.jsp?uid=$uId');

    var response = await http.get(url); // 빌드가 끝날 때까지 기다려
    var dataConvertedJSON =
        json.decode(utf8.decode(response.bodyBytes)); // 한글깨짐방지, map방식으로 변환

    List result = dataConvertedJSON['results'];

    setState(() {
      diaryList.addAll(result);
    });
    print(diaryList);
    return true;
  }
}

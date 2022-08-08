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

    uId = "aaa";
    uNickname = "가슬";
    diaryList = [];
    getJSONData();
    // uId = User.uId;
    // uNickname = User.uNickname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('$uNickname 님\n 감정 캘린더'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$uNickname 님'),
                  const Text('감정 캘린더'),
                ],
              ),
              //calendar
              Column(
                children: [
                  SizedBox(
                    height: 400,
                    width: 350,
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
                                diaryList[i]['d_date']) {
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
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          shape: BoxShape.rectangle,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: Color.fromARGB(178, 186, 104, 200),
                          shape: BoxShape.circle,
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
                            '   작성된 일기가 없습니다. \n일기를 작성해 주세요!',
                            style: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                    : ListView.builder(
                        itemCount: diaryList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DiaryContent(
                                        diaryList:
                                            diaryList[index]); // Map으로 보내
                                  },
                                )).then((value) => getJSONData());
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: index == 0 ? 40 : 10,
                                  child: Text(
                                    index == 0
                                        ? '${diaryList[index]['d_date'].substring(0, 4)}년'
                                        : '',
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 350,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        color: Colors.brown[100],
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              // CircleAvatar(
                                              //   backgroundImage: AssetImage(
                                              //       diaryList[index]
                                              //           ['d_emoji']),
                                              //   radius: 30,
                                              // ),
                                              SizedBox(
                                                width: 250,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      diaryList[index]['d_content'].length > 13
                                                          ? '${diaryList[index]['d_content'].substring(0, 13)}...'
                                                          : diaryList[index]
                                                              ['d_content'],
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '${diaryList[index]['d_date'].substring(6, 7)}월 ${diaryList[index]['d_date'].substring(8, 10)}일',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .brown),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
              ),
            ],
          ),
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

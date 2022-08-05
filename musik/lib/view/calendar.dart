import 'package:flutter/material.dart';
import 'package:musik/userMessage.dart';
import 'package:table_calendar/table_calendar.dart';

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

  @override
  void initState() {
    super.initState();
    uId = User.uId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //calendar
              TableCalendar(
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
                    focusedDay = focusDay; // update `_focusedDay` here as well
                    // cDate = selectedDay.toString().substring(0, 10);
                  });
                  // getJSONData();
                },

                selectedDayPredicate: (DateTime day) {
                  return isSameDay(selectedDay, day);
                },

                // eventLoader: (day) {
                //   List dot = [];

                //   for (int i = 0; i < allDatedata.length; i++) {
                //     if (allDatedata.isNotEmpty) {
                //       if (day.toString().substring(0, 10) ==
                //           allDatedata[i]['cDate']) {
                //         dot.add(true);
                //       }
                //     }
                //   }
                //   for (int a = 0; a < allAnalysisData.length; a++) {
                //     if (allAnalysisData.isNotEmpty) {
                //       if (day.toString().substring(0, 10) ==
                //           allAnalysisData[a]['bDate']) {
                //         dot.add(true);
                //       }
                //     }
                //   }
                //   return dot;
                // },

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
            ],
          ),
        ),
      ),
    );
  }
}

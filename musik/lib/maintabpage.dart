import 'package:flutter/material.dart';
import 'package:musik/userMessage.dart';
import 'package:musik/view/calendar.dart';
import 'package:musik/view/diaryhome.dart';
import 'package:musik/view/diarylist.dart';
import 'package:musik/view/music.dart';
import 'package:musik/view/mypage.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  //property
  late TabController controller;
  late String uId;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    uId = User.uId;
  }

  @override
  void dispose() {
    // super 위에 써줘야함
    controller.dispose(); // ????
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TabBarView(
          controller: controller,
          children: const [
            // mainHome
            DiaryHome(),
            // 달력 페이지
            Calendar(),
            // 다이어리 기록
            DiaryList(),
            // 음악 플레이리스트
            Music(),
            // 마이페이지
            MyPage()
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: TabBar(
        onTap: (value) {
          //
        },
        controller: controller,
        labelColor: Colors.deepPurple,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicatorColor: Colors.indigo,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            icon: Icon(
              Icons.home_rounded,
              color: controller.index == 0 ? Colors.deepPurple : Colors.black,
            ),
            text: "Home",
          ),
          Tab(
            icon: Icon(
              Icons.music_note_rounded,
              color: controller.index == 1 ? Colors.deepPurple : Colors.black,
            ),
            text: "Calendar",
          ),
          Tab(
            icon: Icon(
              Icons.notes_rounded,
              color: controller.index == 2 ? Colors.deepPurple : Colors.black,
            ),
            text: "Record",
          ),
          Tab(
            icon: Icon(
              Icons.calendar_month_rounded,
              color: controller.index == 2 ? Colors.deepPurple : Colors.black,
            ),
            text: "Music",
          ),
          Tab(
            icon: Icon(
              Icons.settings_outlined,
              color: controller.index == 2 ? Colors.deepPurple : Colors.black,
            ),
            text: "Setting",
          ),
        ],
      ),
    );
  }
}

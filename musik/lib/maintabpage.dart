import 'package:flutter/material.dart';
import 'package:musik/userMessage.dart';
import 'package:musik/view/calendar.dart';
import 'package:musik/view/diaryhome.dart';
import 'package:musik/view/music.dart';
import 'package:musik/view/mypage.dart';
import 'package:musik/view/select_emotion.dart';

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
    controller = TabController(length: 4, vsync: this);
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
            SelectEmotion(),
            // 음악 플레이리스트
            Music(),
            // 마이페이지
            // MyPage()
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: TabBar(
        onTap: (value) {
          //
        },
        controller: controller,
        labelColor: Colors.amber,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicatorColor:  Colors.amber,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(
            icon: Icon(
              Icons.home_rounded,
            ),
            text: "Home",
          ),
          Tab(
            icon: Icon(
              Icons.calendar_month_rounded,
            ),
            text: "Calendar",
          ),
          Tab(
            icon: Icon(
              Icons.music_note_rounded,
            ),
            text: "AI music",
          ),
          Tab(
            icon: Icon(
              Icons.notes_rounded,
            ),
            text: "PlayList",
          ),
          // Tab(
          //   icon: Icon(
          //     Icons.settings_outlined,
          //     color: controller.index == 2 ? Colors.deepPurple : Colors.black,
          //   ),
          //   text: "Setting",
          // ),
        ],
      ),
    );
  }
}

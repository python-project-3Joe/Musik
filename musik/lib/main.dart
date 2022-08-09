import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:musik/Login/findMain.dart';
import 'package:musik/Login/findMain2.dart';
import 'package:musik/Login/sign_up.dart';
import 'package:musik/maintabpage.dart';
import 'package:musik/view/calendar.dart';
import 'package:musik/view/diaryadd.dart';
import 'package:musik/view/diarycontent.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:musik/view/diaryhome.dart';
import 'package:musik/view/diarylist.dart';
import 'package:musik/view/emotional_alnalysis.dart';
import 'package:musik/view/emotional_lyrics.dart';
import 'package:musik/view/select_emotion.dart';
import 'package:musik/view/song_detail.dart';
import 'package:musik/view/splashscreen_diary.dart';
import 'package:musik/view/splashscreen_lyrics.dart';
import 'Login/login.dart';

void main() {
  runApp(const MyApp());
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Diary',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AnimatedSplashScreen(
          // 스플래쉬
          splash: 'images/Splash.png',
          splashIconSize: 200,
          duration: 1000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.black,
          nextScreen: const LoginPage()),
      routes: {
        // Login
        '/Sign_up': (context) => const SignUp(),
        '/Log_in': (context) => const LoginPage(),
        '/Find_id': (context) => const FindMain(),
        '/Find_pw': (context) => const FindMain2(),

        // diary 관련 부분
        '/main': (context) => const DiaryHome(),

        // diary 추가
        '/diaryadd': (context) => const DiaryAdd(),

        // diary 감정분석 스플래시 화면
        '/Splashscreen_diary': (context) => const Splashscreen1(),

        // diary 리스트
        '/diarylist': (context) => const DiaryList(),

        // 감정 분석 결과
        '/emotional_analysis': (context) => const EmotionalAnalysis(),

        // 작사 감정 선택
        '/selectEmotion': (context) => const SelectEmotion(),

        // diary 감정분석 스플래시 화면
        '/Splashscreen_lyrics': (context) => const Splashscreen2(),

        // 작사 페이지
        '/emotionalLyrics': (context) => const EmotionalLyrics(),

        // Youtube Link
        '/SongDetail': (context) => const SongDetail(),

        // tabbar 페이지
        '/tabbar': (context) => const MainTabPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/tabbar',
    );
  }
}

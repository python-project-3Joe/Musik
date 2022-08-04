import 'package:flutter/material.dart';
import 'package:musik/view/diaryhome.dart';
import 'view/login.dart';



void main() {
  runApp(const MyApp());
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
      routes: {
        '/signin': (context) => const LoginPage(), // 로그인 화면
        // '/diaryhome': (context) => const DiaryHome(), // 회원 가입 화면
        // 그 외 화면 이동은 MaterialRoute방식으로 사용
      },
      initialRoute: '/signin',
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musik/Login/findMain.dart';
import 'package:musik/Login/findMain2.dart';
import 'package:musik/Login/sign_up.dart';
import 'package:musik/view/diaryhome.dart';
import 'Login/login.dart';

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
        // Login
        '/Sign_up': (context) => const SignUp(),
        '/Log_in': (context) => const LoginPage(),
        '/Find_id': (context) => const FindMain(),
        '/Find_pw': (context) => const FindMain2(),
        '/main': (context) => const DiaryHome(),
      },
      initialRoute: '/main',
      debugShowCheckedModeBanner: false,
    );
  }
}

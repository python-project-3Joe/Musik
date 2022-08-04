import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/signin': (context) => const LoginPage(), // 로그인 화면
        '/signup': (context) => const RegisterPage(), // 회원 가입 화면
      },
      initialRoute:  '/signin',
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:musik/view/emotional_lyrics.dart';

class Splashscreen2 extends StatefulWidget {
  const Splashscreen2({Key? key}) : super(key: key);

  @override
  State<Splashscreen2> createState() => _Splashscreen2State();
}

class _Splashscreen2State extends State<Splashscreen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Diary',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AnimatedSplashScreen(
          // 스플래쉬
          splash: 'images/lyrics_splashscreen.gif',
          splashIconSize: 1500,
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.black,
          nextScreen: const EmotionalLyrics())
          );
  }
}


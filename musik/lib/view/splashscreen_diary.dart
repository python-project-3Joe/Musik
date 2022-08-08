import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:musik/view/emotional_alnalysis.dart';

class Splashscreen1 extends StatefulWidget {
  const Splashscreen1({Key? key}) : super(key: key);

  @override
  State<Splashscreen1> createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Diary',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AnimatedSplashScreen(
          // 스플래쉬
          splash: 'images/diary_splashscreen.gif',
          splashIconSize: 1500,
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.black,
          nextScreen: const EmotionalAnalysis())
          );
  }
}


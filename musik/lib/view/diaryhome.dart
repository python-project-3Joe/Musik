
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DiaryHome extends StatelessWidget {
  final Map users;
  const DiaryHome({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('나의 감정을 기록하면\n뮤식이가 감정을 분석해서\n음악을 추천해줘요'),
            TextButton(
              onPressed: () {
                Navigator.push(context, route)
              },
              child: const Text('기록하기'),),
          ],
        ),
      ),
    );
  }
}
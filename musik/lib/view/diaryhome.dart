import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musik/view/diaryadd.dart';

class DiaryHome extends StatelessWidget {
  const DiaryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('나의 감정을 기록하면\n뮤식이가 감정을 분석해서\n음악을 추천해줘요'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DiaryAdd(); // Map으로 보내
                    },
                  ),
                );
              },
              child: const Text('기록하기'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmotionalAnalysis extends StatefulWidget {
  const EmotionalAnalysis({Key? key}) : super(key: key);

  @override
  State<EmotionalAnalysis> createState() => _EmotionalAnalysisState();
}

class _EmotionalAnalysisState extends State<EmotionalAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('감정 분석 결과'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text('뮤식이가 분석한 결과'),
            Column(
              children: [
                Row(
                  children: [
                    Text('감기에 걸린 날'),
                    Text('의 감정은'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongDetail extends StatefulWidget {
  const SongDetail({Key? key}) : super(key: key);

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    const url = 'https://youtu.be/h7pDGP1XjZM';

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: true,
        ));
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: YoutubePlayer(controller: controller),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.network(
                              // 이미지 url
                              "https://cdnimg.melon.co.kr/cm2/album/images/108/16/959/10816959_20211217144957_500.jpg?c1818ddc493cb2bbb4d268431e6de7b5/melon/resize/282/quality/80/optimize",
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("사랑인가봐") // 노래 제목
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text("멜로망스") // 가수 이름
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text("2022.07.22")],
                        ),
                        Card()
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

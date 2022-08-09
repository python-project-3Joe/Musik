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
          loop: true,
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
      appBar: AppBar(title: Text("노래 제목")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: YoutubePlayer(controller: controller),
            ),
            Container(
              width: 400,
              height: 500,
              child: Column(
                children: [
                  Card(
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
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("가사\n\n") // 노래 제목
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              ' 잘 지냈지? 조금은 어색해 요즘 좋아 보여 인사 나누며 사실 궁금한 게 너무 많았는데 반가움에 멍해졌죠  생각보다 오래 된 것 같은 우리 수다스럽던 그때가 생각나 뭐가 그렇게도 할 말이 많아서 밤을 지새우곤 했죠  그리운 목소리 그리던 얼굴 참 많이도 기다렸어 다시 만나자는 너의 한마디에 울컥 눈물이 나 결국 너였단 걸  알아 기다림의 끝은 기적이 되고 기적 같은 우린 운명처럼  서로를 알아보고 그렇게 눈앞에 서있죠  우리 사랑했던 우리 다시 만나 그때 그 순간 그대로 사랑했고 사랑할 거니까  같이 듣던 노래 그때 그 거리를 이제 혼자 아닌 너와 둘이 걸어 다시 오른쪽에 나란히 발맞춰 같은 노래를 부르죠  그리운 만남을 그리던 날들 참 많이도 기다렸어 다시 너를 만나 더욱 더 소중해 같은 마음이란 걸 알아 기다림의 끝은 기적이 되고 기적 같은 우린 운명처럼  서로를 알아보고 그렇게 눈앞에 서있죠 우리 사랑했던 우리 다시 만나 그때 그 순간 그대로 사랑했고 사랑할 거니까 처음 느낌 그대로 설렘이 가득한 날 고마워 다시 돌아와줘서 그때 그 순간처럼 날 안아줘 결국 기다림의 끝은 기적이 되고 기적 같은 우린 운명처럼  서로를 알아보고 그렇게 눈앞에 서있죠  우리 사랑했던 우리 다시 만나 그때 그 순간 그대로 사랑했고 사랑할 거니까 ',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [],
            )
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongDetail extends StatefulWidget {
  const SongDetail({Key? key}) : super(key: key);

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController controller; // youtube player controller

  late String songname;
  late String singer;
  late String date;
  late String lyrics;

  @override
  void initState() {
    songname = "";
    singer = "";
    date = "";
    lyrics = "";
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
      appBar: AppBar(title: Text("$songname")),
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
                                  Text("$songname") // 노래 제목
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Text("$singer") // 가수 이름
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text("$date")],
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
                                '$lyrics',
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
            ],
          ),
        ),
      ),
    );
  }
}

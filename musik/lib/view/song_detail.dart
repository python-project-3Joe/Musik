import 'package:flutter/material.dart';
import 'package:musik/lyricsMessage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongDetail extends StatefulWidget {
  const SongDetail({Key? key}) : super(key: key);

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController controller; // youtube player controller

  late String songname; // 노래제목
  late String singer; // 가수
  late String lyric; //가사
  late String image; //앨범사진
  late String mlink; //youtube link
  late String date;
  @override
  void initState() {
    songname = Lyrics.mtitle;
    singer = Lyrics.msinger;
    lyric = Lyrics.lyric;
    image = Lyrics.mimage;
    mlink = Lyrics.mlink;
    date = Lyrics.date;
    super.initState();

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(mlink)!,
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("$singer - $songname"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: YoutubePlayer(controller: controller),
              ),
              Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.network(
                              // 이미지 url
                              "$image",
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
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [Text("$date")],
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text("가사\n") // 노래 제목
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '$lyric',
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

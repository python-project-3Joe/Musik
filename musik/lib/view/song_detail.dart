import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongDetail extends StatefulWidget {
  const SongDetail({Key? key}) : super(key: key);

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController ycontroller;

  @override
  void initState() {
    ycontroller = YoutubePlayerController(
      initialVideoId: 'txL-itZYdY4',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            YoutubePlayer(
              controller: ycontroller,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}

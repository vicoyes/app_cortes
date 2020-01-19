import 'package:flutter/material.dart';
// import 'package:youtube_player/youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  final String videoUrl;
  Video(this.videoUrl);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String videoId;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(this.widget.videoUrl);
    print('video id_ $videoId');
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}

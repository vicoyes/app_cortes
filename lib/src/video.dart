import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class Video extends StatefulWidget {
  final String videoUrl;
  Video(this.videoUrl);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String _source = "https://www.youtube.com/watch?v=i1NPS6I5fmA&t=96s";

  @override
  void initState() {
    _source = this.widget.videoUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
    context: context,
    source: _source,
    quality: YoutubeQuality.HD,
    // callbackController is (optional). 
    // use it to control player on your own.
  );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class Video extends StatefulWidget {

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String _source = "i1NPS6I5fmA";

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

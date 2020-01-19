import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hair_app/src/video.dart';

class ImagenGallery extends StatefulWidget {
  final List<dynamic> url;
  final String img;
  final String videoUrl;
  final bool like;
  final String id;

  ImagenGallery(this.url, this.img, this.videoUrl, this.like, this.id);

  @override
  _ImagenGalleryState createState() => _ImagenGalleryState();
}

class _ImagenGalleryState extends State<ImagenGallery> {
  String imgUrl;
  bool _isFavorited;
  var pantalla;
  String userID;

  // compartir img

  void compartir(imgUrl) async {
    var request = await HttpClient().getUrl(Uri.parse(imgUrl));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Cortes de cabello', 'corte.png', bytes, 'image/png');
  }

  // obtener id usuario
  void getUserID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userID = user.uid;
    print(userID);
  }

  @override
  void initState() {
    print(this.widget.img);
    imgUrl = this.widget.url[0];
    pantalla = Image.network(imgUrl);
    _isFavorited = this.widget.like;
    getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 8,
            textTheme: TextTheme(
                title: TextStyle(
              color: Colors.pink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )),
            title: Text('Galeria'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: pantalla,
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_isFavorited) {
                        Firestore.instance
                            .collection('data')
                            .document(userID)
                            .collection('likes')
                            .document(this.widget.id)
                            .delete();
                        setState(() {
                          _isFavorited = false;
                        });
                      } else {
                        Firestore.instance
                            .collection('data')
                            .document(userID)
                            .collection('likes')
                            .document(this.widget.id)
                            .setData({
                          'id': this.widget.id,
                          'url': this.widget.img,
                          'imgs': this.widget.url,
                          'like': true,
                          'video': this.widget.videoUrl
                        });
                        setState(() {
                          _isFavorited = true;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      compartir(imgUrl);
                    },
                  ),
                ],
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: this.widget.url.length,
                    itemBuilder: (context, index) {
                      List<dynamic> data = this.widget.url;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pantalla = Image.network(data[index]);
                            imgUrl = data[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 100,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                child: Image.network(data[index],
                                    fit: BoxFit.cover, loadingBuilder: (context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: Image(
                                      image: AssetImage('img/loading-2.png'),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      pantalla = Video(this.widget.videoUrl);
                      print('video_url: ${this.widget.videoUrl}');
                    });
                  },
                  textColor: Colors.white,
                  color: Colors.pink,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ver Video',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.play_circle_outline),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

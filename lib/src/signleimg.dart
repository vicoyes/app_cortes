import 'package:flutter/material.dart';

class SingleImg extends StatefulWidget {
  String url;
  SingleImg(this.url);

  @override
  _SingleImgState createState() => _SingleImgState();
}

class _SingleImgState extends State<SingleImg> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[900],
      appBar:  AppBar(
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
          body: Container(
            child: Center(
              child: Image.network(this.widget.url),
            ),
          ),
    );

  }
}
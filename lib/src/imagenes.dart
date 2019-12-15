import 'package:flutter/material.dart';

class ImagenGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
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
      ),
    );
  }
}

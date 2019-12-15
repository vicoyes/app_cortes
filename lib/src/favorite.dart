import 'package:flutter/material.dart';
import 'package:hair_app/src/gallery.dart';




class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
String title = 'Favoritos';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 8,
            textTheme: TextTheme(
              title: TextStyle(color: Colors.pink,
              fontSize: 22,
              fontWeight: FontWeight.w700,)
            ),
            title: Text(title),
            
          ),

          body: Gallery(),
        ),
    );
  }
}


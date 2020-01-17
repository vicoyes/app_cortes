import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hair_app/src/gallery.dart';


class Favorite extends StatefulWidget {
  final String userId;
  Favorite(this.userId);


  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
String title = 'Favoritos';
String userID;

@override
  void initState() {
    super.initState();
  }

// obtener id usuario
  void getUserID() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userID = user.uid;
  }  


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

          body: Gallery(this.widget.userId),
        ),
    );
  }
}


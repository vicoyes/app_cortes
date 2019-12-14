import 'package:flutter/material.dart';


class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
String title = 'Favoritos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
    );
  }
}


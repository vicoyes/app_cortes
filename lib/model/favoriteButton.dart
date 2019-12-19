import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class FavoriteBtn {

  Database base;

  initdB() async{
    base = await openDatabase('Favoritos',
    version: 1,
    onCreate: (Database db, int version){
      db.execute("CREATE TABLET favorite (id INTEGER PRIMARY KEY, url TEXT NO NULL);");
    } 
    );
  }

  int id;
  bool like;
  String urlImage;
   
   FavoriteBtn(this.id, this.like, this.urlImage);

}



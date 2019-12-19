

import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:hair_app/model/favoriteImg.dart';
export 'package:hair_app/model/favoriteImg.dart';

class DBProvider {


  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database  async {

    if (_database != null) return _database;

    _database = await initDB();

    return _database;

  }


  initDB() async{

    Directory  documentsDirectory = await getApplicationDocumentsDirectory();
    

    final path = join(documentsDirectory.path, 'FavoriteDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{

        await db.execute(
          'CREATE TABLE favorito ('
          'id INTEGER PRIMAY KEY,'
          'idImg INTEGER,'
          'url TEXT,'
          'like TEXT'
          ')' 
        );

      }
    );

  }

  // crear registro

  nuevoFavoritoRaw(FavoriteImg nuevoFavorito) async{

    final db =await database;

    final res = await  db.rawInsert(
      "INSERT Into favorito (id, idImg, url, like) "
      "VALUES( '${nuevoFavorito.id}', '${nuevoFavorito.idImg}', '${nuevoFavorito.url}', '${nuevoFavorito.like}')"
    );

    return res;

  }

  nuevoFavorito(FavoriteImg nuevoFavorito) async{

    final db = await database;

    final res = await db.insert('favorito', nuevoFavorito.toJson());

    return res;
  }


  // SELECT obtener informacion,

 Future<FavoriteImg> getFavoritosid(int id) async {
    final db = await database;
    final res = await db.query('favorito', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? FavoriteImg.fromJson(res.first) : null;
  }


  Future<List<FavoriteImg>> getAllFavoritos() async{

      final db = await database;
      final res = await db.query('favoritos');

      List<FavoriteImg> list = res.isNotEmpty 
      ? res.map((c) => FavoriteImg.fromJson(c)).toList()
      : [];

      return list;
  }

  Future<List<FavoriteImg>> getAllLike( String like) async{

      final db = await database;
      final res = await db.rawQuery("SELECT * FROM favoritos WHERE like='$like'");

      List<FavoriteImg> list = res.isNotEmpty 
      ? res.map((c) => FavoriteImg.fromJson(c)).toList()
      : [];

      return list;
  }
  
  // actulizar registro

  Future<int> updateFavoritos(FavoriteImg nuevoFavorito) async {

    final db = await database;
    final res = await db.update('favoritos', nuevoFavorito.toJson(), where: 'id =?', whereArgs: [nuevoFavorito.id]  );

    return res;
  }

// Eliminar registro

Future<int>deleteFavorito(int id) async {

  final db = await database;
  final res = await db.delete('favorito', where: 'id = ?', whereArgs: [id]);
  return res;

}

Future<int> deleteFavoritoAll() async {

  final db = await database;
  final res = await db.delete('favorito');
  return res;

}
  
}
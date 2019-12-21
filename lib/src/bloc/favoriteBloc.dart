
import 'dart:async';
import 'package:hair_app/src/providers/db_provider.dart';

class FavoritosBloc {

 static final FavoritosBloc _singleton = new FavoritosBloc._internal();

 factory FavoritosBloc(){
   return _singleton;
 }

 FavoritosBloc._internal(){
   // obtener todos los favoritos
   obtenerFavoritos();

 }

 final _favoritosController = StreamController<List<FavoriteImg>>.broadcast();

Stream<List<FavoriteImg>> get favoriteStream => _favoritosController.stream;

dispose(){
  _favoritosController?.close();
}



obtenerFavoritos() async {

  _favoritosController.sink.add( await DBProvider.db.getAllFavoritos() );
}

borraruni(int id) async {
   await DBProvider.db.deleteFavorito(id);
   obtenerFavoritos();
}

borrartodo() async {
 await DBProvider.db.deleteFavoritoAll();
 obtenerFavoritos();
}

}
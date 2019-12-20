import 'package:flutter/material.dart';
import 'package:hair_app/src/providers/db_provider.dart';


class FavoriteButton extends StatefulWidget {
 final String id;
 final String url;

 FavoriteButton(this.url, this.id);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;
  String id;
  String url;
  
@override
 _toggleFavorite(url, id  )  {

 setState(() {
    
    if (_isFavorited) {
      _isFavorited = false;
      int idImage = int.parse(id);
      DBProvider.db.deleteFavorito(idImage);
      
    } else {
      _isFavorited = true;
      final favorito = FavoriteImg(id: int.parse(id), url: url, like: _isFavorited.toString());
      DBProvider.db.nuevoFavorito(favorito);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onPressed: ()async {
       await _toggleFavorite(this.widget.url, this.widget.id);
      } 
    );
  }
}

import 'package:flutter/material.dart';


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
_toggleFavorite(url, id  ) {
  setState(() {
    
    if (_isFavorited) {
      _isFavorited = false;
      print(url);
      print("No me gusta");
    } else {
      _isFavorited = true;
      print(id);
      print("Si me gusta");
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onPressed: (){
        _toggleFavorite(this.widget.url, this.widget.id);
      } 
    );
  }
}

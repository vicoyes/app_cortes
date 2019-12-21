// dependenias
import 'package:flutter/material.dart';
import 'package:hair_app/src/listado.dart';




class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  bool loading;

  @override
  Widget build(BuildContext context) {
    return Listado('Popular');
  }
}

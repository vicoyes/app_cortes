import 'package:flutter/material.dart';
import 'package:hair_app/src/home.dart';
import 'package:hair_app/src/inicio.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Cortes de pelo 2019",
      home: Home(),
    );
  }
}
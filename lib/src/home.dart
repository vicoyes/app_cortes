import 'package:flutter/material.dart';
import 'package:hair_app/src/favorite.dart';
import 'package:hair_app/src/inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

int index = 0;
final List<Widget> screens =[
  Inicio(),
  Favorite()
];

Widget currentScreen = Favorite();

final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      )
    );
  }
}
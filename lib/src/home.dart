import 'package:flutter/material.dart';
import 'package:hair_app/src/favorite.dart';
import 'package:hair_app/src/inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

int currentetab;
final List<Widget> screens =[
  Inicio(),
  Favorite()
];

Widget currentScreen = Inicio();

final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,

      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
           padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = Inicio();
                        currentetab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.home, color: currentetab == 0 ? Colors.pink : Colors.grey, ),
                        Text("Inicio", style: TextStyle(color: currentetab == 0 ? Colors.pink : Colors.grey,),)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = Favorite();
                        currentetab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite_border, color: currentetab == 1 ? Colors.pink : Colors.grey, ),
                        Text("Favoritos", style: TextStyle(color: currentetab == 1 ? Colors.pink : Colors.grey,),)
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
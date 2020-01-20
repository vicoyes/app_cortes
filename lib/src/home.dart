
import 'package:flutter/material.dart';
import 'package:hair_app/src/favorite.dart';
import 'package:hair_app/src/inicio.dart';
import 'package:hair_app/src/providers/push_notification_provaider.dart';



class Home extends StatefulWidget {
  final String userId;
  Home(this.userId);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

int currentetab = 0;
final List<Widget> screens =[
  Inicio(),

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
        elevation: 20,
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
                        currentScreen = Favorite(this.widget.userId);
                        currentetab = 1;
                        // getUserID();
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
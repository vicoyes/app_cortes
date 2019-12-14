import 'package:flutter/material.dart';
import 'modelHair.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 8,
            textTheme: TextTheme(
              title: TextStyle(color: Colors.pink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              
              )
            ),
            title: const Text('',
            textAlign: TextAlign.center,
            
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.pink,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.pink,
              ),
              tabs: choices.map((Choice choice) {
                return Container(
                  padding: EdgeInsets.only(left: 8, right:8 , bottom:0 ),
                  child:Tab(
                  text: choice.title,
                ) 

                );
              }).toList(),
            ),
              )
            )
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
          bottomNavigationBar:  BottomNavigationBar(
       currentIndex: 0, 
       elevation: 10,
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Inicio'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.favorite_border),
           title: new Text('Mis Favoritos'),
         )
       ],
     ),

        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: choice.lista.length,
      itemBuilder: (BuildContext context, int index){
        return Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      ),
          child: Column(
            children: <Widget>[
              Image.network(choice.lista[index]),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Icon(Icons.favorite_border,
                        color: Colors.pink
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share,
                        color: Colors.pink,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}



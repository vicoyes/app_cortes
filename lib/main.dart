import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
                  padding: EdgeInsets.only(left: 12, right: 12, bottom:0 ),
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
                padding: const EdgeInsets.all(16.0),
                child: ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
          bottomNavigationBar:  BottomNavigationBar(
       currentIndex: 1, 
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

class Choice {
  const Choice({this.title});

  final String title;
  
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Popular'),
  const Choice(title: 'Cabello Corto'),
  const Choice(title: 'Cabello Medio'),
  const Choice(title: 'Cabello Largo'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
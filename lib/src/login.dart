// login widget
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hair_app/src/home.dart';
import 'package:hair_app/src/providers/push_notification_provaider.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var uid;

  @override
  void initState() {
    sigIn().then((FirebaseAuth user) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: Home(uid)));
    }).catchError((e) {
      print(e);
    });
    super.initState();
    final initNotification = new PushNotification();

    initNotification.initNotification();

    initNotification.mensaje.listen((argumento){
        print('Argumeto: $argumento');

        final stack = SnackBar(
          content: Text(argumento),
          action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () => null,
          ),
        );

        Scaffold.of(context).showSnackBar(stack);
    });
    
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseAuth> sigIn() async {
    AuthResult user = await FirebaseAuth.instance.signInAnonymously();
    uid = user.user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink),
        home: Scaffold(
          backgroundColor: Colors.pink,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cortes de cabellos 2020',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

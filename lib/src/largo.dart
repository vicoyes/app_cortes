// dependencias
import 'package:flutter/material.dart';
import 'package:hair_app/src/listado.dart';



class Largo extends StatefulWidget {
  @override
  _LargoState createState() => _LargoState();
}

class _LargoState extends State<Largo> {

    

  @override
  Widget build(BuildContext context) {
    return Listado('Largos');
  }
}

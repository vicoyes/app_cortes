import 'package:flutter/material.dart';
import 'package:hair_app/src/listado.dart';

// widget

class Medio extends StatefulWidget {
  @override
  _MedioState createState() => _MedioState();
}

class _MedioState extends State<Medio> {


  @override
  Widget build(BuildContext context) {
    return Listado('Medios');
  }
}

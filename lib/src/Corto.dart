// dependencias
import 'package:flutter/material.dart';

import 'listado.dart';

class Corto extends StatefulWidget {
  @override
  _CortoState createState() => _CortoState();
}

class _CortoState extends State<Corto> {

  @override
  Widget build(BuildContext context) {
    return Listado('Cortos');
  }
}




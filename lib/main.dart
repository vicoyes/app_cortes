import 'package:flutter/material.dart';
import 'src/home.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {'/': (context) => Home()},
      ),
    );
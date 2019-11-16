import 'package:flutter/material.dart';
import 'screen/home/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Totality Todo',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new HomePage(),
    );
  }
}

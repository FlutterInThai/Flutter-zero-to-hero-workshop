import 'package:flutter/material.dart';
import 'configs/config.dart';
import 'screens/home/home_page.dart';

class MyApp extends StatelessWidget {
  final Config config;

  MyApp(this.config);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: config.appName,
      ),
    );
  }
}

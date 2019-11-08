import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'configs/config.dart';
import 'screens/home/home_page.dart';

class MyApp extends StatelessWidget {
  final Config config;

  MyApp(this.config);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: config.appName,
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          )
        : MaterialApp(
            title: config.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(
              title: config.appName,
            ),
          );
  }
}

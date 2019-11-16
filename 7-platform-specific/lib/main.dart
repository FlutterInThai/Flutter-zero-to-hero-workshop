import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('co.getlinks.platform.channel');
  String dataFromPlatform = "";

  @override
  void didChangeDependencies() {
    platform.setMethodCallHandler(_handleMethod);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              dataFromPlatform,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            RaisedButton(
              onPressed: _showNativeView,
              child: Text("Open Native Activity"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showNativeView() async {
    await platform.invokeMethod('showEditText');
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "message":
        setState(() {
          dataFromPlatform = call.arguments.toString();
        });
        return Future.value("");
    }
  }
}

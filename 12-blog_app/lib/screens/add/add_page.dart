import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'หัวเรื่อง',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _title = value,
                style: TextStyle(fontSize: 20.0),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'เนื้อหา',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) => _content = value,
              ),
              RaisedButton(
                onPressed: () async {
                  final form = _formKey.currentState;
                  form.save();
                  await Firestore.instance
                      .collection('posts')
                      .add({'title': _title, 'content': _content});
                  Navigator.pop(context);
                },
                child: Text('บันทึก'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

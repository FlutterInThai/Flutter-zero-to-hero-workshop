import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:totality_todo/model/Todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  Todo todo;
  DetailPage({this.todo});

  @override
  _DetailPageState createState() => _DetailPageState(todo);
}

class _DetailPageState extends State<DetailPage> {
  Firestore db = Firestore.instance;
  Todo _todo;
  _DetailPageState(this._todo);

  _addTodoItem(String text) async {
    if (text.length > 0) {
      if (_todo == null) {
        var data = new Map<String, dynamic>();
        data['title'] = text;
        data['isDone'] = false;
        db.collection('Todo').add(data);
      } else {
        _todo.reference.updateData({'title': text});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body:
        TextFormField (
          autofocus: true,
          onFieldSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context, Todo(val));
          },
          style: TextStyle(fontSize: 30.0, color: Colors.black),
          decoration: InputDecoration(hintText: "Enter todo here...", contentPadding: EdgeInsets.all(10.0)),
          initialValue: _todo != null ? _todo.title :  "",
      ),
    );
  }
}

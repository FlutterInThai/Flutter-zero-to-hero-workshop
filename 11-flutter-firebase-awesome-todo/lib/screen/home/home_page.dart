


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:totality_todo/screen/detail/detail_page.dart';
import 'package:totality_todo/model/Todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextStyle _todoTextStyle(bool isDone) {
    if (isDone) {
      return TextStyle(fontSize: 30.0, decoration: TextDecoration.lineThrough);
    } else {
      return TextStyle(fontSize: 30.0);
    }
  }

  _pushToAddPage() async {
    Todo result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailPage();
    }));
    setState(() {

    });
  }

  _pushToDetailPage(Todo todo) async {
    Todo result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailPage(
        todo: todo,
      );
    }));
    setState(() {});
  }

  void _removeTodoItem(Todo todo) {
    setState(() {

    });
  }

  _promptRemoveTodoItem(Todo todo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                _pushToDetailPage(todo);
              },
              child: const Text('Detail'),
            ),
            SimpleDialogOption(
              onPressed: () { },
              child: const Text('Delete'),
            ),],
          );
        });
  }

  _buildRow(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection('Todo').orderBy('isDone').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data.documents);
        });
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Todo> _todos = snapshot
        .map((documentSnapshot) => Todo.fromSnapshot(documentSnapshot))
        .toList();

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onLongPress: () => _promptRemoveTodoItem(_todos[index]),
          child: CheckboxListTile(
            value: _todos[index].isDone,
            title: Text(_todos[index].title,
                style: _todoTextStyle(_todos[index].isDone)),
            onChanged: (bool selected) {
              _todos[index].isDone = selected;
              _todos[index].reference.updateData({'isDone': selected});
            },
          ),
        );
      },
      itemCount: _todos.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: _buildRow(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pushToAddPage(),
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final DocumentReference reference;
  String title;
  bool isDone;

  Todo(this.title, {this.isDone = false, this.reference});

  Todo.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['isDone'] != null),
        title = map['title'],
        isDone = map['isDone'];

  Todo.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
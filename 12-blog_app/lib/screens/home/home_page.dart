import 'package:blog_app/models/post.dart';
import 'package:blog_app/screens/add/add_page.dart';
import 'package:blog_app/screens/detail/detail_page.dart';
import 'package:blog_app/screens/home/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addPost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          print(snapshot.data.documents);
          return _buildList(context, snapshot.data.documents);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPost,
        tooltip: 'Add post',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((DocumentSnapshot doc) {
        Post post = Post.fromSnapshot(doc);
        return GestureDetector(
          child: PostCard(post),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(post);
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

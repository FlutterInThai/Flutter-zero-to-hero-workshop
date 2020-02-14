import 'package:blog_app/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  Post post;
  DetailPage(this.post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Column(
        children: <Widget>[
          if (post.imageUrl != null)
            Image.network(post.imageUrl, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(post.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

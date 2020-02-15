import 'package:blog_app/models/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  PostCard(this.post);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (post.imageUrl != null && post.imageUrl.isNotEmpty)
              Image.network(post.imageUrl, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

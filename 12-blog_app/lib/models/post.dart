import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class Post {
  String title;
  String imageUrl;
  String content;

  Post({
    this.title,
    this.imageUrl,
    this.content,
  });

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        title: json["title"],
        imageUrl: json["image_url"],
        content: json["content"],
      );

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    return Post.fromMap(snapshot.data);
  }

  Map<String, dynamic> toMap() => {
        "title": title,
        "image_url": imageUrl,
        "content": content,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteNews {
  FavoriteNews({
    this.documentRef,
    this.title,
    this.description,
    this.cover,
  });

  FavoriteNews.fromMap(Map<String, dynamic> map, {this.documentRef})
      : title = map['title'],
        description = map['description'],
        cover = map['cover'];

  FavoriteNews.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, documentRef: snapshot.reference);

  final DocumentReference documentRef;
  final String title;
  final String cover;
  final String description;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'cover': cover,
      };
}

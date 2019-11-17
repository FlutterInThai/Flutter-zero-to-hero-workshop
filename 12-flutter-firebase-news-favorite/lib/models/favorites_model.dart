import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/data/favorite_news.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritesModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Firestore db = Firestore.instance;

  List<FavoriteNews> _favorites = <FavoriteNews>[];

  List<FavoriteNews> get favorites => _favorites;

  void fetchFavorites() async {
    if (_favorites.isEmpty) {
      _isLoading = true;
    }
    notifyListeners();
    var favDoc = await db.collection('favorites').getDocuments();
    _favorites = favDoc.documents
        .map((documentSnapshot) => FavoriteNews.fromSnapshot(documentSnapshot))
        .toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> saveFavorite(FavoriteNews favoriteNews) async {
    DocumentReference documentReference =
        await db.collection('favorites').add(favoriteNews.toMap());
    return documentReference != null;
  }

  static FavoritesModel of(BuildContext context) =>
      ScopedModel.of<FavoritesModel>(context);
}

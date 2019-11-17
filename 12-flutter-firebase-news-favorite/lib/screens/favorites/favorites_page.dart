import 'package:flutter/material.dart';
import 'package:news_reader/models/favorites_model.dart';
import 'package:news_reader/screens/favorites/widgets/fav_card.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    FavoritesModel favoritesModel = FavoritesModel.of(context);
    favoritesModel.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FavoritesModel>(
        builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: FavCard(model.favorites[index]),
                    ),
                  );
                }),
      );
    });
  }
}

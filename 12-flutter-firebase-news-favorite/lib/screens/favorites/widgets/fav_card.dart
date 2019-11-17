import 'package:flutter/material.dart';
import 'package:news_reader/data/favorite_news.dart';

class FavCard extends StatelessWidget {
  FavCard(this.favNews);

  final FavoriteNews favNews;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 1.5 / 3,
                child: Image.network(
                  favNews.cover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
            child: Text(
              favNews.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

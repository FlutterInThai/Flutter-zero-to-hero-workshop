import 'package:flutter/material.dart';
import 'package:news_reader/data/favorite_news.dart';
import 'package:news_reader/data/news.dart';
import 'package:news_reader/models/favorites_model.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/screens/feed/widgets/news_card.dart';
import 'package:news_reader/screens/news_detail/news_detail_page.dart';
import 'package:scoped_model/scoped_model.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FavoritesModel favoritesModel;
  @override
  void initState() {
    super.initState();
    HeadlineModel headlineModel = HeadlineModel.of(context);
    headlineModel.fetchNews();
  }

  @override
  void didChangeDependencies() {
    favoritesModel = FavoritesModel.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HeadlineModel>(
        builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model.newsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        openDetailPage(model.newsList[index]);
                      },
                      child: NewsCard(
                        news: model.newsList[index],
                        onPressed: () {
                          News news = model.newsList[index];
                          favoritesModel.saveFavorite(FavoriteNews(
                            title: news.title,
                            cover: news.urlToImage,
                            description: news.description,
                          ));
                          showSnackbar(news, context);
                        },
                      ),
                    ),
                  );
                }),
      );
    });
  }

  void showSnackbar(News news, BuildContext context) {
    final snackBar = SnackBar(content: Text('${news.title} Added!'));

    // Find the Scaffold in the Widget tree and use it to show a SnackBar
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void openDetailPage(News news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return NewsDetailPage(news: news);
      }),
    );
  }
}

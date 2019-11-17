import 'package:flutter/material.dart';
import 'package:news_reader/configs/config.dart';
import 'package:news_reader/models/favorites_model.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/screens/home/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsReaderApp extends StatefulWidget {
  NewsReaderApp(this._config);

  final Config _config;

  @override
  _NewsReaderAppState createState() => _NewsReaderAppState();
}

class _NewsReaderAppState extends State<NewsReaderApp> {
  HeadlineModel headlineModel;
  FavoritesModel favoritesModel;

  @override
  void initState() {
    headlineModel = HeadlineModel();
    favoritesModel = FavoritesModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<FavoritesModel>(
      model: favoritesModel,
      child: ScopedModel<HeadlineModel>(
        model: headlineModel,
        child: MaterialApp(
          title: widget._config.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}

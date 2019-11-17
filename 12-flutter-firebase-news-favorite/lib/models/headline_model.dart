import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_reader/data/news.dart';
import 'package:scoped_model/scoped_model.dart';

class HeadlineModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<News> _newsList = <News>[];

  List<News> get newsList => _newsList;

  void fetchNews() async {
    if (_newsList.isEmpty) {
      _isLoading = true;
    }
    notifyListeners();
    final response = await http.get("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6316e304547d4808b3a632a04c45ad89");
    var responseJson = json.decode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(responseJson);
    _newsList = newsResponse.articles;
    _isLoading = false;
    notifyListeners();
  }

  static HeadlineModel of(BuildContext context) => ScopedModel.of<HeadlineModel>(context);
}

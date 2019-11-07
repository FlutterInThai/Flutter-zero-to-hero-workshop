import 'package:flutter/material.dart';
import 'package:flutter_workshop_feeds/data/news.dart';

class NewsDetailPage extends StatelessWidget {
  NewsDetailPage(this.news);
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(news.title),
        ),
        body: Column(
          children: <Widget>[
            Image.network(news.cover),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    news.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(news.createdAt.toString()),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(news.content),
              ),
            ),
          ],
        ));
  }
}

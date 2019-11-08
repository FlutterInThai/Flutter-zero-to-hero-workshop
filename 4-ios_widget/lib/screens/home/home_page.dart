import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workshop_feeds/data/news.dart';
import 'package:flutter_workshop_feeds/screens/home/widgets/news_card.dart';
import 'package:flutter_workshop_feeds/screens/news_detail/news_detail_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  List<News> news = List<News>();

  @override
  void initState() {
    news.add(News(
        cover:
            "https://cdn.mos.cms.futurecdn.net/vHdvWTgFUsVq7r73rVPPh6-970-80.jpg",
        title: "Huawei ban: the global fallout explained",
        content:
            "Huawei has found itself at the center of a global tussle between the US and China after Trump administration placed the Chinese brand on the ‘entity list’, limiting the business US companies could do with it.",
        createdAt: DateTime.parse("20190507")));
    news.add(News(
        cover:
            "https://cdn.mos.cms.futurecdn.net/LzBAUxudHEegMhNd9ynPbV-970-80.jpg",
        title:
            "Apple improved the 2019 MacBook Pro keyboards after all, iFixit uncovers",
        content:
            "Apple didn’t just improve the processors within its existing MacBook Pro models, but apparently the company has also improved the keyboards that these refreshed laptops offer, teardown site iFixit has learned.",
        createdAt: DateTime.parse("20190510")));
    news.add(News(
        cover:
            "https://techcrunch.com/wp-content/uploads/2019/10/Scopely-LA-Office.jpg",
        title: "LA-based gaming studio Scopely raises 200M at a 1.7B valuation",
        content:
            "The Los Angeles-based mobile game development studio Scopely has become America’s newest unicorn thanks to a 200 million financing, which values the company at a whopping 1.7 billion.",
        createdAt: DateTime.parse("20191029")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.assistant),
        title: Text('Feed'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.work),
        title: Text('Headline'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star_border),
        title: Text('Favorites'),
      ),
    ];

    Widget child = Center(
      child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  openDetailPage(news[index]);
                },
                child: NewsCard(news[index]));
          }),
    );

    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: navItems),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(
                    'Headlines',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                child: child,
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: navItems,
              onTap: (int index) {
                setState(() {
                  pageIndex = index;
                });
              },
              currentIndex: pageIndex,
            ),
          );
  }

  void openDetailPage(News news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return NewsDetailPage(news);
      }),
    );
  }
}

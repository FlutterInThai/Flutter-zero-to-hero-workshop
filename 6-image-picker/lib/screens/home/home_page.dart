import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_workshop_feeds/data/news.dart';
import 'package:flutter_workshop_feeds/screens/home/widgets/news_card.dart';
import 'package:flutter_workshop_feeds/screens/news_detail/news_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  bool isLoading = false;
  List<News> news = List<News>();
  File _image;

  _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get('https://newsapi.org/v2/top-headlines'
        '?sources=techcrunch&apiKey=6316e304547d4808b3a632a04c45ad89');
    var responseJson = json.decode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(responseJson);
    setState(() {
      news = newsResponse.articles;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                getImage();
              },
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: _image != null
                      ? Image.file(_image).image
                      : NetworkImage(
                          'https://png.pngtree.com/element_origin_min_pic/16/11/15/89a1f35d71139a37bb3fe572a954f2f8.jpg'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    openDetailPage(news[index]);
                  },
                  child: NewsCard(news[index]));
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
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
        ],
        onTap: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
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

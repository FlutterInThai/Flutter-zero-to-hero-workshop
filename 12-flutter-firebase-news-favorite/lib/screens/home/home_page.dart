import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_reader/screens/favorites/favorites_page.dart';
import 'package:news_reader/screens/feed/feed_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Headlines',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
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
      body: pageIndex == 1
          ? FeedPage()
          : pageIndex == 2 ? FavoritesPage() : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            title: Text('My Feed'),
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
}

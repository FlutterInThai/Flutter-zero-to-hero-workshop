import 'package:flutter/material.dart';
import 'package:news_reader/configs/config.dart';
import 'package:news_reader/models/favorites_model.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/news_reader_app.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  Config config = Config(
    appName: 'News',
    flavorName: 'production',
  );
  runApp(NewsReaderApp(config));
}

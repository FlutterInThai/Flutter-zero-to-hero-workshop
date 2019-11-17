import 'package:flutter/material.dart';
import 'package:news_reader/configs/config.dart';
import 'package:news_reader/news_reader_app.dart';

void main() {
  Config config = Config(
    appName: 'News Dev',
    flavorName: 'development',
  );
  runApp(NewsReaderApp(config));
}

import 'package:flutter/material.dart';
import 'app.dart';
import 'configs/config.dart';

void main() {
  Config config = Config(
    appName: 'News',
    flavorName: 'production',
  );
  return runApp(MyApp(config));
}

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Config {
  Config({
    @required this.flavorName,
    @required this.appName,
  });

  final String flavorName;
  final String appName;
}

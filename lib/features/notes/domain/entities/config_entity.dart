import 'package:flutter/material.dart';

abstract class ConfigEntity {
  final bool networkConnected;
  final String? apiUrl;
  final String? apiKey;
  final bool inDarkMode;
  final Color seedColor;

  ConfigEntity({this.apiUrl, this.apiKey, required this.networkConnected, required this.inDarkMode, required this.seedColor});
}
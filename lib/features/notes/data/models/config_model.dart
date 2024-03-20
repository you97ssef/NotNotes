import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:not_notes/config/theme/app_theme.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';

class ConfigModel extends ConfigEntity {
  ConfigModel({super.apiKey, super.apiUrl, required super.networkConnected, required super.inDarkMode, required super.seedColor});

  factory ConfigModel.fromString(String configString, {required bool networkConnected}) {
    final json = jsonDecode(configString);

    return ConfigModel(
      apiKey: json['apiKey'],
      apiUrl: json['apiUrl'],
      inDarkMode: json['inDarkMode'] ?? AppTheme.initialInDarkMode,
      seedColor: json['seedColor'] != null ? Color(json['seedColor']) : AppTheme.initialSeedColor,
      networkConnected: networkConnected,
    );
  }

  String toJson() {
    return jsonEncode({
      'apiKey': apiKey,
      'apiUrl': apiUrl,
      'inDarkMode': inDarkMode,
      'seedColor': seedColor.value,
    });
  }
}

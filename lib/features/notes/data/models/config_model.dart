import 'dart:convert';

import 'package:not_notes/features/notes/domain/entities/config_entity.dart';

class ConfigModel extends ConfigEntity {
  ConfigModel({super.apiKey, super.apiUrl});

  factory ConfigModel.fromString(String configString) {
    final json = jsonDecode(configString);

    return ConfigModel(
      apiKey: json['apiKey'],
      apiUrl: json['apiUrl'],
    );
  }

  String toJson() {
    return jsonEncode({
      'apiKey': apiKey,
      'apiUrl': apiUrl,
    });
  }
}

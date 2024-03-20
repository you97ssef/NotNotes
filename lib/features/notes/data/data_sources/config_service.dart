import 'dart:io';

import 'package:not_notes/config/theme/app_theme.dart';
import 'package:not_notes/features/notes/data/models/config_model.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfigService {
  final String _key;
  final SharedPreferences _preferences;

  ConfigService(this._key, this._preferences);

  Future<ConfigEntity> loadConfig() async {
    final String? config = _preferences.getString(_key);

    var networkConnected = await checkNetwork();

    if (config == null) {
      var config = ConfigModel(networkConnected: networkConnected, inDarkMode: AppTheme.initialInDarkMode, seedColor: AppTheme.initialSeedColor);
      await saveConfig(config);
      return config;
    }

    return ConfigModel.fromString(config, networkConnected: networkConnected);
  }

  Future<void> saveConfig(ConfigEntity config) async {
    await _preferences.setString(_key, (config as ConfigModel).toJson());
  }

  Future<bool> checkCloud(ConfigEntity config) async {
    if (config.apiKey == null && config.apiUrl == null) return true;

    final response = await http.get(Uri.parse('${config.apiUrl}?code=${config.apiKey}&query=check'));

    return response.body == 'Valid code';
  }

  Future<bool> checkNetwork() async {
    try {
      final result = await http.get(Uri.parse('www.google.com'));
      return result.statusCode == 200;
    } on SocketException catch (_) {
      return false;
    }
  }
}

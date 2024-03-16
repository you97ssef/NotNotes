import 'package:not_notes/features/notes/data/models/config_model.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  final String _key;
  final SharedPreferences _preferences;

  ConfigService(this._key, this._preferences);


  Future<ConfigEntity> loadConfig() async {
    final String? config = _preferences.getString(_key);

    if (config == null) {
      var config = ConfigModel();
      await saveConfig(config);
      return config;
    }

    return ConfigModel.fromString(config);
  }

  Future<void> saveConfig(ConfigEntity config) async {
    await _preferences.setString(_key, (config as ConfigModel).toJson());
  }
}
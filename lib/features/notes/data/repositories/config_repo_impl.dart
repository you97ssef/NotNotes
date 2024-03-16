import 'package:not_notes/features/notes/data/data_sources/config_service.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class ConfigRepoImpl implements ConfigRepo {
  final ConfigService _service;

  ConfigRepoImpl(this._service);

  @override
  Future<void> save(ConfigEntity config) async {
    await _service.saveConfig(config);
  }

  @override
  Future<ConfigEntity> fetch() async {
    return await _service.loadConfig();
  }
}
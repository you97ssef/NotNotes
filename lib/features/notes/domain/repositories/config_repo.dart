import 'package:not_notes/features/notes/domain/entities/config_entity.dart';

abstract class ConfigRepo {
  Future<void> save(ConfigEntity config);
  Future<ConfigEntity> fetch();
  Future<bool> checkCloud(ConfigEntity config);
  Future<bool> checkNetwork();
}
import 'package:not_notes/core/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class SaveConfigUseCase implements UseCase<void, ConfigEntity> {
  final ConfigRepo _repo;

  SaveConfigUseCase(this._repo);

  @override
  Future<void> call(ConfigEntity config) async {
    return await _repo.save(config);
  }
}
import 'package:not_notes/core/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class FetchConfigUseCase implements UseCase<ConfigEntity, void> {
  final ConfigRepo _repo;

  FetchConfigUseCase(this._repo);

  @override
  Future<ConfigEntity> call(void params) async {
    return await _repo.fetch();
  }
}
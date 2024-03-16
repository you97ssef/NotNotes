import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class SaveConfigUseCase implements UseCase<CaseState<void>, ConfigEntity> {
  final ConfigRepo _repo;

  SaveConfigUseCase(this._repo);

  @override
  Future<CaseState<void>> call({required ConfigEntity params}) async {
    try {
      return CaseSuccess(await _repo.save(params));
    } catch (e) {
      return CaseError(e as Exception);
    }
  }
}

import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class FetchConfigUseCase implements UseCase<CaseState<ConfigEntity>, void> {
  final ConfigRepo _repo;

  FetchConfigUseCase(this._repo);

  @override
  Future<CaseState<ConfigEntity>> call({void params}) async {
    try {
      return CaseSuccess(await _repo.fetch());
    } catch (e) {
      return CaseError(e as Exception);
    }
  }
}

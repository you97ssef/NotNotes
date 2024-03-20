import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';

class CheckNetworkUseCase implements UseCase<CaseState<bool>, void> {
  final ConfigRepo _repo;

  CheckNetworkUseCase(this._repo);

  @override
  Future<CaseState<bool>> call({void params}) async {
    try {
      return CaseSuccess(await _repo.checkNetwork());
    } catch (e) {
      return CaseError(e);
    }
  }
}

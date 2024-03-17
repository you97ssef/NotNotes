import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class DeleteNoteUseCase implements UseCase<CaseState<void>, String> {
  final NoteRepo _repo;

  DeleteNoteUseCase(this._repo);

  @override
  Future<CaseState<void>> call({required String params}) async {
    try {
      return CaseSuccess(await _repo.deleteNote(params));
    } catch (e) {
      return CaseError(e);
    }
  }
}

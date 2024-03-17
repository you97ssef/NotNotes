import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class SaveNoteUseCase implements UseCase<CaseState<void>, NoteEntity> {
  final NoteRepo _repo;

  SaveNoteUseCase(this._repo);

  @override
  Future<CaseState<void>> call({required NoteEntity params}) async {
    try {
      return CaseSuccess(_repo.saveNote(note: params));
    } catch (e) {
      return CaseError(e);
    }
  }
}

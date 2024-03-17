import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_state.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/core/use_case/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class FetchNotesUseCase implements UseCase<CaseState<List<NoteEntity>>, void> {
  final NoteRepo _repo;

  FetchNotesUseCase(this._repo);

  @override
  Future<CaseState<List<NoteEntity>>> call({void params}) async {
    try {
      return CaseSuccess(await _repo.fetchNotes());
    } catch (e) {
      return CaseError(e);
    }
  }
}

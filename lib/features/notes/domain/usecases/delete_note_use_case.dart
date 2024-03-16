import 'package:not_notes/core/use_case.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class DeleteNoteUseCase implements UseCase<void, String> {
  final NoteRepo _repo;

  DeleteNoteUseCase(this._repo);

  @override
  Future<void> call(String id) async {
    return await _repo.deleteNote(id);
  }
}

import 'package:not_notes/core/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class SaveNoteUseCase implements UseCase<void, NoteEntity> {
  final NoteRepo _repo;

  SaveNoteUseCase(this._repo);

  @override
  Future<void> call(NoteEntity note) async {
    return await _repo.saveNote(note: note);
  }
}

import 'package:not_notes/core/use_case.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';

class FetchNotesUseCase implements UseCase<List<NoteEntity>, void> {
  final NoteRepo _repo;

  FetchNotesUseCase(this._repo);

  @override
  Future<List<NoteEntity>> call(void params) async {
    return await _repo.fetchNotes();
  }
}

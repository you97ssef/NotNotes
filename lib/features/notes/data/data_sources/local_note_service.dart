import 'package:hive/hive.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';

class LocalNoteService {
  final Box<NoteEntity> _notes;

  LocalNoteService(this._notes);

  Future<void> save(NoteEntity note) async {
    await _notes.put(note.id, note);
  }

  Future<void> delete(String id) async {
    await _notes.delete(id);
  }

  Future<List<NoteEntity>> get() async {
    final List<NoteEntity> result = _notes.values.toList();
    return result;
  }
}

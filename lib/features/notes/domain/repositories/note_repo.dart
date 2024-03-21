import 'dart:async';

import 'package:not_notes/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepo {
  Future<List<NoteEntity>> fetchNotes();
  Future<void> saveNote({required NoteEntity note});
  Future<void> deleteNote(String id);

  static sortNotes(List<NoteEntity> notes) {
    notes.sort((a, b) => b.updatedTime.compareTo(a.updatedTime));
    return notes;
  }
}

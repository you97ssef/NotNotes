part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

final class FetchNotesEvent extends NoteEvent {}

final class SaveNoteEvent extends NoteEvent {
  final NoteEntity note;

  SaveNoteEvent(this.note);
}

final class DeleteNoteEvent extends NoteEvent {
  final String noteId;

  DeleteNoteEvent(this.noteId);
}

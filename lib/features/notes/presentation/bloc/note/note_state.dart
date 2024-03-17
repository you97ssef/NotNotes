part of 'note_bloc.dart';

@immutable
sealed class NoteState {
  final List<NoteEntity>? notes;
  final Object? error;

  const NoteState({this.notes, this.error});
}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  const NoteLoaded(List<NoteEntity> notes) : super(notes: notes);
}

final class NoteError extends NoteState {
  const NoteError(Object error) : super(error: error);
}

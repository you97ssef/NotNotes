import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/delete_note_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/fetch_notes_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/save_note_use_case.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FetchNotesUseCase _fetch;
  final SaveNoteUseCase _save;
  final DeleteNoteUseCase _delete;

  NoteBloc(this._fetch, this._save, this._delete) : super(NoteLoading()) {
    on<FetchNotesEvent>(_onFetchNotes);
    on<SaveNoteEvent>(_onSaveNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(NoteEvent event, Emitter<NoteState> emit) async {
    var result = await _fetch();

    if (result is CaseSuccess<List<NoteEntity>>) {
      emit(NoteLoaded(result.data));
    }

    if (result is CaseError<List<NoteEntity>>) {
      emit(NoteError(result.error));
    }
  }

  Future<void> _onSaveNote(SaveNoteEvent event, Emitter<NoteState> emit) async {
    var state = this.state;

    emit(NoteLoading());

    var result = await _save(params: event.note);

    if (result is CaseSuccess<void>) {
      var notes = state.notes!;

      var index = notes.indexWhere((note) => note.id == event.note.id);

      if (index != -1) {
        notes[index] = event.note;
      } else {
        notes.add(event.note);
      }
      notes = NoteRepo.sortNotes(notes);

      emit(NoteLoaded(notes));
    }

    if (result is CaseError<void>) {
      emit(NoteError(result.error));
    }
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    var result = await _delete(params: event.noteId);

    if (result is CaseSuccess<void>) {
      var notes = state.notes!;

      notes.removeWhere((note) => note.id == event.noteId);

      emit(NoteLoaded(notes));
    }

    if (result is CaseError<void>) {
      emit(NoteError(result.error));
    }
  }
}

import 'package:not_notes/features/notes/data/data_sources/local_note_service.dart';
import 'package:not_notes/features/notes/data/data_sources/remote_note_service.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';

class NoteRepoImpl implements NoteRepo {
  final ConfigBloc _bloc;
  final LocalNoteService _localService;
  final RemoteNoteService _cloudService;

  NoteRepoImpl(this._bloc, this._localService, this._cloudService);

  @override
  Future<List<NoteEntity>> fetchNotes() async {
    if (_bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      var cloudNotes = await _cloudService.get();
      var localNotes = await _localService.get();

      return _sortNotes(_mergeLists(localNotes, cloudNotes));
    } else {
      return _sortNotes(await _localService.get());
    }
  }

  List<NoteEntity> _mergeLists(List<NoteEntity> local, List<NoteEntity> cloud) {
    Map<String, NoteEntity> mergedMap = {};

    for (NoteEntity note in local) {
      _syncNote(mergedMap, note, false);
    }

    for (NoteEntity note in cloud) {
      _syncNote(mergedMap, note, true);
    }

    return mergedMap.values.toList();
  }

  void _syncNote(Map<String, NoteEntity> mergedMap, NoteEntity note, bool isCloud) {
    if (mergedMap.containsKey(note.id)) {
      if (note.updatedTime.isAfter(mergedMap[note.id]!.updatedTime)) {
        mergedMap[note.id] = note;
        if (isCloud) {
          _localService.save(note);
        } else {
          _cloudService.save(note);
        }
      }
    } else {
      mergedMap[note.id] = note;
      if (isCloud) {
        _localService.save(note);
      } else {
        _cloudService.save(note);
      }
    }
  }

  List<NoteEntity> _sortNotes(List<NoteEntity> notes) {
    notes.sort((a, b) => b.updatedTime.compareTo(a.updatedTime));
    return notes;
  }

  @override
  Future<void> saveNote({required NoteEntity note}) async {
    if (_bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      await _localService.save(note);
      await _cloudService.save(note);
    } else {
      await _localService.save(note);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    if (_bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      await _localService.delete(id);
      await _cloudService.delete(id);
    } else {
      await _localService.delete(id);
    }
  }
}

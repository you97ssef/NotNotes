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
    if (_bloc.state.config!.networkConnected && _bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      var cloudNotes = await _cloudService.get();
      var localNotes = await _localService.get();

      return NoteRepo.sortNotes(await _mergeLists(localNotes, cloudNotes));
    } else {
      return NoteRepo.sortNotes(await _localService.get());
    }
  }

  Future<List<NoteEntity>> _mergeLists(List<NoteEntity> local, List<NoteEntity> cloud) async {
    List<NoteEntity> syncedList = [];

    for (var ln in local) {
      var cn = cloud.where((n) => n.id == ln.id).firstOrNull;
      if (cn == null || ln.updatedTime.isAfter(cn.updatedTime)) {
        await _cloudService.save(ln);
        syncedList.add(ln);
      } else {
        syncedList.add(cn);
      }
    }

    for (var cn in cloud) {
      var ln = local.where((n) => n.id == cn.id).firstOrNull;
      if (ln == null || cn.updatedTime.isAfter(ln.updatedTime)) {
        await _localService.save(cn);
        if (!syncedList.contains(cn)) {
          syncedList.add(cn);
        }
      }
    }

    return syncedList;
  }

  @override
  Future<void> saveNote({required NoteEntity note}) async {
    if (_bloc.state.config!.networkConnected && _bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      await _localService.save(note);
      await _cloudService.save(note);
    } else {
      await _localService.save(note);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    if (_bloc.state.config!.networkConnected && _bloc.state.config!.apiKey != null && _bloc.state.config!.apiUrl != null) {
      await _localService.delete(id);
      await _cloudService.delete(id);
    } else {
      await _localService.delete(id);
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:not_notes/features/notes/data/models/note_model.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';

class RemoteNoteService {
  final ConfigBloc _bloc;

  RemoteNoteService(this._bloc);

  Future<List<NoteEntity>> get() async {
    final response = await http.get(Uri.parse('${_bloc.state.config!.apiUrl}?code=${_bloc.state.config!.apiKey}&query=all'));

    if (response.statusCode < 400) {
      return jsonDecode(response.body).map<NoteModel>((note) {
        try {
          return NoteModel.fromJson(note);
        } catch (e) {
          return NoteModel.fresh(title: 'ErrorCloud', content: 'Error Entry in the cloud try to fix it');
        }
      }).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<bool> save(NoteEntity note) async {
    final response = await http.get(
      Uri.parse(
          '${_bloc.state.config!.apiUrl}?code=${_bloc.state.config!.apiKey}&query=save&id=${note.id}&title=${base64.encode(utf8.encode(note.title))}&content=${base64.encode(utf8.encode(note.content))}&createdTime=${note.createdTime.toIso8601String()}&updatedTime=${note.updatedTime.toIso8601String()}'),
    );

    if (response.statusCode < 400) {
      return response.body == 'Data updated successfully' || response.body == 'Data saved successfully';
    } else {
      throw Exception('Failed to create note');
    }
  }

  Future<bool> delete(String id) async {
    final response = await http.get(Uri.parse('${_bloc.state.config!.apiUrl}?code=${_bloc.state.config!.apiKey}&query=delete&id=$id'));

    if (response.statusCode < 400) {
      return response.body == 'Data deleted successfully';
    } else {
      throw Exception('Failed to delete note');
    }
  }
}

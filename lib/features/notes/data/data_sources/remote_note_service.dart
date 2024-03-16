import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:not_notes/features/notes/data/models/note_model.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';

class CloudNoteService {
  ConfigEntity config;

  CloudNoteService(this.config);

  Future<List<NoteEntity>> get() async {
    final response = await http.get(Uri.parse('${config.apiUrl}?code=${config.apiKey}&query=all'));

    if (response.statusCode < 400) {
      return jsonDecode(response.body).map<NoteModel>((note) => NoteModel.fromJson(note)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<bool> save(NoteEntity note) async {
    final response = await http.get(
      Uri.parse('${config.apiUrl}?code=${config.apiKey}&query=save&id=${note.id}&title=${note.title}&content=${note.content}&createdTime=${note.createdTime}&updatedTime=${note.updatedTime}'),
    );

    if (response.statusCode < 400) {
      return response.body == 'Data updated successfully' || response.body == 'Data saved successfully';
    } else {
      throw Exception('Failed to create note');
    }
  }

  Future<bool> delete(String id) async {
    final response = await http.get(Uri.parse('${config.apiUrl}?code=${config.apiKey}&query=delete&id=$id'));

    if (response.statusCode < 400) {
      return response.body == 'Data deleted successfully';
    } else {
      throw Exception('Failed to delete note');
    }
  }
}

import 'package:not_notes/features/notes/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({required super.id, required super.title, required super.content, required super.createdTime, required super.updatedTime});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdTime: DateTime.parse(json['createdTime']),
      updatedTime: DateTime.parse(json['updatedTime']),
    );
  }
}
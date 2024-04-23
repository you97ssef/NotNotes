import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:not_notes/core/util/util.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject implements NoteEntity {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final String content;

  @override
  @HiveField(3)
  final DateTime createdTime;

  @override
  @HiveField(4)
  final DateTime updatedTime;

  NoteModel({required this.id, required this.title, required this.content, required this.createdTime, required this.updatedTime});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'].toString(),
      title: utf8.decode(base64.decode(json['title'])),
      content: utf8.decode(base64.decode(json['content'])),
      createdTime: DateTime.parse(json['createdTime']),
      updatedTime: DateTime.parse(json['updatedTime']),
    );
  }

  factory NoteModel.fresh({required String title, required String content}) {
    var now = DateTime.now();
    return NoteModel(
      id: Util.randomString(10),
      title: title,
      content: content,
      createdTime: now,
      updatedTime: now,
    );
  }

  factory NoteModel.refresh(NoteEntity entity, {required String title, required String content}) {
    return NoteModel(
      id: entity.id,
      title: title,
      content: content,
      createdTime: entity.createdTime,
      updatedTime: DateTime.now(),
    );
  }
}

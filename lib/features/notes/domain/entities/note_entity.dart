abstract class NoteEntity {
  final String id;
  final String title;
  final String content;
  final DateTime createdTime;
  final DateTime updatedTime;

  NoteEntity({required this.id, required this.title, required this.content, required this.createdTime, required this.updatedTime});
}

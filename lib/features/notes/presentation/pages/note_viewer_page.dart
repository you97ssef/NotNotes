import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/functions/app_functions.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/note_editor_page.dart';

class NoteViewerPage extends StatelessWidget {
  static const String route = '/note_viewer';
  final NoteEntity note;

  const NoteViewerPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(note.title),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: AppWidgets.padding,
      child: Markdown(
        data: note.content,
        selectable: true,
        onTapText: () => Navigator.pushNamed(context, NoteEditorPage.route, arguments: note),
      ),
    );
  }

  _floatingActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: 'primary',
          label: const Text('Edit'),
          onPressed: () => Navigator.pushNamed(context, NoteEditorPage.route, arguments: note),
          icon: const Icon(Icons.edit),
        ),
        AppWidgets.gap,
        FloatingActionButton(
          heroTag: 'secondary',
          onPressed: () => _deleteNote(context),
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }

  _deleteNote(BuildContext context) async {
    var deleted = await AppFunctions.confirm(context, 'Delete Note', 'Are you sure you want to delete this note?');

    if (deleted != null && deleted && context.mounted) {
      BlocProvider.of<NoteBloc>(context).add(DeleteNoteEvent(note.id));
      Navigator.pop(context);
    }
  }
}

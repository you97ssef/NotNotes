import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/data/models/note_model.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/note_viewer_page.dart';

class NoteEditorPage extends StatefulWidget {
  static const String route = '/note_editor';
  final NoteEntity? note;

  const NoteEditorPage({super.key, this.note});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  NoteEntity? note;

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    note = widget.note;
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(note == null ? 'New Note' : 'Edit Note'),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: AppWidgets.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleField(),
            AppWidgets.gap,
            _contentField(),
            AppWidgets.gap,
            _buildSaveButtons(),
          ],
        ),
      ),
    );
  }

  TextFormField _titleField() {
    return TextFormField(
      controller: titleController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      validator: _validator,
    );
  }

  Widget _contentField() {
    return Expanded(
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: contentController,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Content',
          alignLabelWithHint: true,
        ),
        validator: _validator,
      ),
    );
  }

  Widget _buildSaveButtons() {
    return BlocConsumer<NoteBloc, NoteState>(
      listenWhen: (previous, current) {
        return previous is NoteLoading && current is NoteLoaded;
      },
      listener: (context, state) {
        if (widget.note != null) Navigator.pop(context);
        Navigator.popAndPushNamed(context, NoteViewerPage.route, arguments: note);
      },
      builder: (context, state) {
        if (state is NoteLoading) {
          return AppWidgets.loading;
        } else if (state is NoteError) {
          return Column(
            children: [
              const Text('There was an error saving the note, Retry?'),
              AppWidgets.gap,
              _saveButton(context),
            ],
          );
        }

        return _saveButton(context);
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: 'primary',
          onPressed: () => _saveNote(context),
          icon: const Icon(Icons.save),
          label: const Text('Save Note'),
        ),
        AppWidgets.gap,
        FloatingActionButton(
          heroTag: 'secondary',
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.cancel),
        ),
      ],
    );
  }

  void _saveNote(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      note = note == null
          ? NoteModel.fresh(
              title: titleController.text,
              content: contentController.text,
            )
          : NoteModel.refresh(
              note!,
              title: titleController.text,
              content: contentController.text,
            );

      context.read<NoteBloc>().add(SaveNoteEvent(note!));
    }
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}

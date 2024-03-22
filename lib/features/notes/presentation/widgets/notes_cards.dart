import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/functions/app_functions.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/presentation/widgets/reload_widget.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/note_viewer_page.dart';

class NotesCards extends StatelessWidget {
  const NotesCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.mediumLogoSize * 1.8,
      child: BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
        if (state is NoteLoading) {
          return AppWidgets.loading;
        }
        if (state is NoteLoaded) {
          return _viewNotes(state.notes!);
        }
        return ReloadWidget(reloadFunction: () => BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent()));
      }),
    );
  }

  Widget _viewNotes(List<NoteEntity> notes) {
    return Center(
      child: notes.isEmpty
          ? const Text('No Notes Found')
          : 
      
      ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          var note = notes[index];
          return Card(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, NoteViewerPage.route, arguments: note),
              child: Container(
                width: AppConstants.logoSize * 1.4,
                padding: AppWidgets.padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppFunctions.timeAgo(note.updatedTime),
                    ),
                    Text(
                      note.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

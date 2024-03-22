import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/functions/app_functions.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/presentation/widgets/reload_widget.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/note_editor_page.dart';
import 'package:not_notes/features/notes/presentation/pages/note_viewer_page.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NoteBloc>().state;

    return Drawer(
      child: Column(
        children: [
          _drawerTop(context, state),
          _buildNotes(context, state),
          _drawerBottom(),
        ],
      ),
    );
  }

  Widget _buildNotes(BuildContext context, NoteState state) {
    if (state is NoteLoading) {
      return const Expanded(child: AppWidgets.loading);
    }
    if (state is NoteLoaded) {
      return _viewNotes(state);
    }
    return Expanded(
      child: ReloadWidget(
        reloadFunction: () => BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent()),
        size: AppConstants.mediumLogoSize,
      ),
    );
  }

  Widget _viewNotes(NoteState state) {
    return Expanded(
      child: state.notes!.isEmpty
          ? const Center(
              child: Text('No Notes Found'),
            )
          : ListView.builder(
              itemCount: state.notes!.length,
              itemBuilder: (context, index) {
                var note = state.notes![index];
                return ListTile(
                    title: Text(note.title),
                    subtitle: Text(
                      AppFunctions.timeAgo(note.updatedTime),
                    ),
                    onTap: () => {
                          Navigator.pop(context),
                          Navigator.pushNamed(context, NoteViewerPage.route, arguments: note),
                        });
              },
            ),
    );
  }

  Widget _drawerTop(BuildContext context, NoteState state) {
    return SizedBox(
      height: AppConstants.logoSize,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppWidgets.gap,
            Text(
              AppConstants.title,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            AppWidgets.smallGap,
            state is NoteLoaded
                ? FilledButton.icon(
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.pushNamed(context, NoteEditorPage.route),
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Note'),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _drawerBottom() {
    return Container(
      padding: AppWidgets.mediumPadding,
      child: const Center(
        child: Text('${AppConstants.title} - ${AppConstants.version}'),
      ),
    );
  }
}

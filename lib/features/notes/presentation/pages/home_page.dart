import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/presentation/widgets/reload_widget.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/note_editor_page.dart';
import 'package:not_notes/features/notes/presentation/pages/settings_page.dart';
import 'package:not_notes/features/notes/presentation/widgets/notes_cards.dart';
import 'package:not_notes/features/notes/presentation/widgets/side_drawer.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ConfigBloc>().state;

    return Scaffold(
      appBar: _appBar(context, state),
      floatingActionButton: _floatingActionButton(context, state),
      drawer: const SideDrawer(),
      body: _body(context, state),
    );
  }

  AppBar? _appBar(BuildContext context, ConfigState state) {
    if (state.config != null) {
      return AppBar(
        title: const Text('Not Notes'),
        actions: [
          _internetConnectionAction(context, state),
          AppWidgets.mediumGap,
          IconButton(
            constraints: const BoxConstraints.tightFor(width: kToolbarHeight, height: kToolbarHeight),
            onPressed: () => Navigator.pushNamed(context, SettingsPage.route),
            icon: const Icon(Icons.settings),
          ),
        ],
      );
    }
    return null;
  }

  Widget _internetConnectionAction(BuildContext context, ConfigState state) {
    if (state.config!.networkConnected == false) {
      return IconButton(
        onPressed: () => context.read<ConfigBloc>().add(CheckNetworkEvent()),
        icon: const Icon(Icons.wifi_off),
      );
    }
    return const Icon(Icons.wifi);
  }

  Widget _floatingActionButton(BuildContext context, ConfigState state) {
    if (state.config != null) {
      var noteState = context.watch<NoteBloc>().state;

      if (noteState is NoteLoaded) {
        return FloatingActionButton(
          heroTag: 'primary',
          onPressed: () => Navigator.pushNamed(context, NoteEditorPage.route),
          child: const Icon(Icons.note_add),
        );
      } else if (noteState is NoteError) {
        return FloatingActionButton(
          heroTag: 'primary',
          onPressed: () => context.read<NoteBloc>().add(FetchNotesEvent()),
          child: const Icon(Icons.error),
        );
      } else {
        return const Hero(tag: 'primary', child: CircularProgressIndicator());
      }
    }
    return const SizedBox();
  }

  Widget _body(BuildContext context, ConfigState state) {
    if (state is ConfigLoading) {
      return AppWidgets.loading;
    } else if (state is ConfigError) {
      return ReloadWidget(
        reloadFunction: () => context.read<ConfigBloc>().add(FetchConfigEvent()),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note,
              size: AppConstants.logoSize,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              'Not Notes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Where you manage your notes.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppWidgets.gap,
            const NotesCards(),
          ],
        ),
      );
    }
  }
}

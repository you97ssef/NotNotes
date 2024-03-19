import 'package:flutter/material.dart';
import 'package:not_notes/features/notes/domain/entities/note_entity.dart';
import 'package:not_notes/features/notes/presentation/pages/home_page.dart';
import 'package:not_notes/features/notes/presentation/pages/note_editor_page.dart';
import 'package:not_notes/features/notes/presentation/pages/note_viewer_page.dart';
import 'package:not_notes/features/notes/presentation/pages/settings_page.dart';
import 'package:not_notes/features/notes/presentation/pages/unknown_page.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return _materialPageRoute(const HomePage());
      case NoteEditorPage.route:
        return _materialPageRoute(NoteEditorPage(note: settings.arguments as NoteEntity?));
      case NoteViewerPage.route:
        return _materialPageRoute(NoteViewerPage(note: settings.arguments as NoteEntity));
      case SettingsPage.route:
        return _materialPageRoute(const SettingsPage());
      default:
        return _materialPageRoute(const UnknownPage());
    }
  }

  static Route _materialPageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}

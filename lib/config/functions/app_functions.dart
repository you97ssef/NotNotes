import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:not_notes/config/dependencies/singletons.dart';
import 'package:not_notes/features/notes/data/models/note_model.dart';

class AppFunctions {
  static Future<bool?> confirm(BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  static String timeAgo(DateTime date) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(date);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} years ago';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  }

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    await initSingletons();
  }
}

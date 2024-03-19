import 'package:hive/hive.dart';
import 'package:not_notes/config/constants/config_constants.dart';
import 'package:not_notes/config/constants/note_constants.dart';
import 'package:not_notes/config/dependencies/dependency.dart';
import 'package:not_notes/features/notes/data/data_sources/config_service.dart';
import 'package:not_notes/features/notes/data/data_sources/local_note_service.dart';
import 'package:not_notes/features/notes/data/data_sources/remote_note_service.dart';
import 'package:not_notes/features/notes/data/models/note_model.dart';
import 'package:not_notes/features/notes/data/repositories/config_repo_impl.dart';
import 'package:not_notes/features/notes/data/repositories/note_repo_impl.dart';
import 'package:not_notes/features/notes/domain/repositories/config_repo.dart';
import 'package:not_notes/features/notes/domain/repositories/note_repo.dart';
import 'package:not_notes/features/notes/domain/use_cases/config/check_network_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/config/fetch_config_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/config/save_config_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/delete_note_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/fetch_notes_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/note/save_note_use_case.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initSingletons() async {
  // Config

  var preferences = await SharedPreferences.getInstance();

  // Services
  dependency.registerSingleton<ConfigService>(ConfigService(configKey, preferences));

  // Repositories
  dependency.registerSingleton<ConfigRepo>(ConfigRepoImpl(dependency()));

  // UseCases
  dependency.registerSingleton<FetchConfigUseCase>(FetchConfigUseCase(dependency()));
  dependency.registerSingleton<SaveConfigUseCase>(SaveConfigUseCase(dependency()));
  dependency.registerSingleton<CheckNetworkUseCase>(CheckNetworkUseCase(dependency()));

  // Blocs
  dependency.registerSingleton<ConfigBloc>(ConfigBloc(dependency(), dependency(), dependency()));

  // ---

  // Notes

  var box = await Hive.openBox<NoteModel>(noteBox);

  // Services
  dependency.registerSingleton<LocalNoteService>(LocalNoteService(box));
  dependency.registerSingleton<RemoteNoteService>(RemoteNoteService(dependency()));

  // Repositories
  dependency.registerSingleton<NoteRepo>(NoteRepoImpl(dependency(), dependency(), dependency()));

  // UseCases
  dependency.registerSingleton<FetchNotesUseCase>(FetchNotesUseCase(dependency()));
  dependency.registerSingleton<SaveNoteUseCase>(SaveNoteUseCase(dependency()));
  dependency.registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(dependency()));

  // Blocs
  dependency.registerSingleton<NoteBloc>(NoteBloc(dependency(), dependency(), dependency()));
}

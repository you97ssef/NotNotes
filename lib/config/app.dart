import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/dependencies/dependency.dart';
import 'package:not_notes/config/routes/app_routes.dart';
import 'package:not_notes/config/theme/app_scroll.dart';
import 'package:not_notes/config/theme/app_theme.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';
import 'package:not_notes/features/notes/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildProvidersAndApp(context);
  }

  MultiBlocProvider _buildProvidersAndApp(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConfigBloc>(create: (_) => dependency()..add(FetchConfigEvent())),
        BlocProvider<NoteBloc>(create: (_) => dependency()..add(FetchNotesEvent())),
      ],
      child: _buildMaterialApp(context),
    );
  }

  Widget _buildMaterialApp(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) => MaterialApp(
        scrollBehavior: AppScroll(),
        title: AppConstants.title,
        debugShowCheckedModeBanner: AppTheme.visibleDebugBanner,
        theme: AppTheme.theme(state.config),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_notes/config/constants/app_constants.dart';
import 'package:not_notes/config/widgets/app_widgets.dart';
import 'package:not_notes/features/notes/data/models/config_model.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/presentation/bloc/config/config_bloc.dart';
import 'package:not_notes/features/notes/presentation/bloc/note/note_bloc.dart';

class SettingsPage extends StatefulWidget {
  static const String route = '/settings';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final apiUrlController = TextEditingController();
  final apiKeyController = TextEditingController();
  late ConfigEntity usedConfig;
  late bool inDarkMode;
  late Color seedColor;

  @override
  void initState() {
    super.initState();
    usedConfig = context.read<ConfigBloc>().state.config!;
    apiUrlController.text = usedConfig.apiUrl ?? '';
    apiKeyController.text = usedConfig.apiKey ?? '';
    inDarkMode = usedConfig.inDarkMode;
    seedColor = usedConfig.seedColor;
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
      title: const Text('Settings'),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppWidgets.padding,
        child: Center(
          child: BlocConsumer<ConfigBloc, ConfigState>(
            listener: (context, state) {
              if (state is ConfigLoaded) {
                if (usedConfig.apiKey != state.config!.apiKey || usedConfig.apiUrl != state.config!.apiUrl) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Config saved')));
                  context.read<NoteBloc>().add(FetchNotesEvent());
                }
                usedConfig = state.config!;
              }
            },
            builder: (context, state) {
              return usedConfig.networkConnected ? _form(context, state) : _recheckNetwork(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _recheckNetwork(ConfigState state) {
    Widget recheckButtonPart = FloatingActionButton.extended(
      heroTag: 'primary',
      onPressed: () => context.read<ConfigBloc>().add(CheckNetworkEvent()),
      icon: const Icon(Icons.refresh),
      label: const Text('Recheck Network'),
    );

    if (state is ConfigLoading) {
      recheckButtonPart = AppWidgets.loading;
    }

    if (state is ConfigError) {
      recheckButtonPart = Column(
        children: [
          const Text('There was an error checking the network, Retry?'),
          AppWidgets.gap,
          recheckButtonPart,
        ],
      );
    }

    return Column(
      children: [
        const Text('No network connection, please check your network connection and try again'),
        AppWidgets.gap,
        recheckButtonPart,
      ],
    );
  }

  Form _form(BuildContext context, ConfigState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ..._cloud(),
          AppWidgets.gap,
          ..._theme(context),
          AppWidgets.gap,
          _saveConfigButtonSpace(state),
        ],
      ),
    );
  }

  List<Widget> _cloud() {
    return [
      Text('Cloud API Config', style: Theme.of(context).textTheme.headlineMedium),
      AppWidgets.mediumGap,
      _field('Cloud api URL', apiUrlController),
      AppWidgets.mediumGap,
      _field('Cloud api Key', apiKeyController),
    ];
  }

  List<Widget> _theme(BuildContext context) {
    return [
      Text('Theme Config', style: Theme.of(context).textTheme.headlineMedium),
      AppWidgets.mediumGap,
      Row(
        children: [
          const Text('Dark Mode'),
          const Spacer(),
          Switch(
            value: inDarkMode,
            onChanged: (value) => setState(() {
              inDarkMode = value;
            }),
          ),
        ],
      ),
      AppWidgets.mediumGap,
      Text('Seed Color', style: Theme.of(context).textTheme.headlineSmall),
      Wrap(
        children: [
          _colorContainer(Colors.red),
          _colorContainer(Colors.pink),
          _colorContainer(Colors.purple),
          _colorContainer(Colors.deepPurple),
          _colorContainer(Colors.indigo),
          _colorContainer(Colors.blue),
          _colorContainer(Colors.lightBlue),
          _colorContainer(Colors.cyan),
          _colorContainer(Colors.teal),
          _colorContainer(Colors.green),
          _colorContainer(Colors.lightGreen),
          _colorContainer(Colors.lime),
          _colorContainer(Colors.yellow),
          _colorContainer(Colors.amber),
          _colorContainer(Colors.orange),
          _colorContainer(Colors.deepOrange),
          _colorContainer(Colors.brown),
          _colorContainer(Colors.blueGrey),
        ],
      ),
    ];
  }

  Widget _colorContainer(Color color) {
    return Padding(
      padding: AppWidgets.mediumPadding,
      child: InkWell(
        borderRadius: AppWidgets.primaryBorderRadius,
        onTap: () => setState(() {
          seedColor = color;
        }),
        child: Container(
          width: AppConstants.mediumLogoSize,
          height: AppConstants.mediumLogoSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppWidgets.primaryBorderRadius,
            border: Border.all(
              color: seedColor.value == color.value ? Theme.of(context).colorScheme.onBackground : Colors.transparent,
              width: AppConstants.borderSize,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _field(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
    );
  }

  Widget _saveConfigButtonSpace(ConfigState state) {
    Widget saveConfigButton = FloatingActionButton.extended(
      heroTag: 'primary',
      onPressed: () => _saveConfig(context),
      icon: const Icon(Icons.save),
      label: const Text('Save Config'),
    );

    if (state is ConfigLoading) {
      saveConfigButton = AppWidgets.loading;
    }

    if (state is ConfigError) {
      saveConfigButton = Column(
        children: [
          const Text('There was an error saving the config, Retry?'),
          AppWidgets.gap,
          saveConfigButton,
        ],
      );
    }

    return saveConfigButton;
  }

  void _saveConfig(BuildContext context) {
    var configToSave = ConfigModel(
      apiKey: apiKeyController.text == '' ? null : apiKeyController.text,
      apiUrl: apiUrlController.text == '' ? null : apiUrlController.text,
      networkConnected: usedConfig.networkConnected,
      inDarkMode: inDarkMode,
      seedColor: seedColor,
    );

    context.read<ConfigBloc>().add(SaveConfigEvent(configToSave));
  }
}

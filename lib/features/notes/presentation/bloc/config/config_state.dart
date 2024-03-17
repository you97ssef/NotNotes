part of 'config_bloc.dart';

@immutable
sealed class ConfigState {
  final ConfigEntity? config;
  final Object? error;

  const ConfigState({this.config, this.error});
}

final class ConfigLoading extends ConfigState {}

final class ConfigLoaded extends ConfigState {
  const ConfigLoaded(ConfigEntity config) : super(config: config);
}

final class ConfigError extends ConfigState {
  const ConfigError(Object error) : super(error: error);
}

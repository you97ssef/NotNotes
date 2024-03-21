part of 'config_bloc.dart';

@immutable
sealed class ConfigEvent {}

final class CheckNetworkEvent extends ConfigEvent {}

final class FetchConfigEvent extends ConfigEvent {}

final class SaveConfigEvent extends ConfigEvent {
  final ConfigEntity config;

  SaveConfigEvent(this.config);
}

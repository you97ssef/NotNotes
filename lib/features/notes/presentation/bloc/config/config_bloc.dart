import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:not_notes/core/use_case/case_error.dart';
import 'package:not_notes/core/use_case/case_success.dart';
import 'package:not_notes/features/notes/domain/entities/config_entity.dart';
import 'package:not_notes/features/notes/domain/use_cases/config/save_config_use_case.dart';
import 'package:not_notes/features/notes/domain/use_cases/config/fetch_config_use_case.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final FetchConfigUseCase _fetch;
  final SaveConfigUseCase _save;

  ConfigBloc(this._fetch, this._save) : super(ConfigLoading()) {
    on<FetchConfigEvent>(_onFetchConfig);
    on<SaveConfigEvent>(_onSaveConfig);
  }

  _onFetchConfig(FetchConfigEvent event, Emitter<ConfigState> emit) async {
    var result = await _fetch();

    if (result is CaseSuccess<ConfigEntity>) {
      emit(ConfigLoaded(result.data));
    }

    if (result is CaseError<ConfigEntity>) {
      emit(ConfigError(result.error));
    }
  }

  _onSaveConfig(SaveConfigEvent event, Emitter<ConfigState> emit) async {
    var result = await _save(params: event.config);

    if (result is CaseSuccess<void>) {
      emit(ConfigLoaded(event.config));
    }

    if (result is CaseError<void>) {
      emit(ConfigError(result.error));
    }
  }
}

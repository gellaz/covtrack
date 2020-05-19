import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/settings/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc(this.settingsRepository) : assert(settingsRepository != null);

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState();
    } else if (event is SettingChanged) {
      yield* _mapSettingsChangedToState(event.key, event.value);
    }
  }

  Stream<SettingsState> _mapAppLoadedToState() async* {
    yield SettingsLoadInProgress();
    try {
      final settings = await settingsRepository.getSettings();
      yield SettingsLoadSuccess(settings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }

  Stream<SettingsState> _mapSettingsChangedToState(
    String key,
    dynamic value,
  ) async* {
    yield SettingsLoadInProgress();
    try {
      await settingsRepository.saveKV(key, value);
      final settings = await settingsRepository.getSettings();
      yield SettingsLoadSuccess(settings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }
}

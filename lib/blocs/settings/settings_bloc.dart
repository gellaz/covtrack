import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/settings.dart';
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
      yield* _mapAppStartedToState();
    } else if (event is ChangeSettings) {
      yield* _mapChangeSettingsToState(event.newSettings);
    }
  }

  Stream<SettingsState> _mapAppStartedToState() async* {
    yield SettingsLoading();
    final firstRun = await settingsRepository.isFirstRun();
    if (firstRun) {
      final createdSettings = await settingsRepository.initSettings();
      yield SettingsCreated(createdSettings);
    } else {
      final loadedSettings = await settingsRepository.loadSettings();
      yield SettingsLoaded(loadedSettings);
    }
  }

  Stream<SettingsState> _mapChangeSettingsToState(
    Map<String, dynamic> newSettings,
  ) async* {
    await settingsRepository.saveSettings(newSettings);
    final settings = Settings();
    settings.updateFromMap(settingsMap: newSettings);
    yield SettingsChanged(settings);
  }
}

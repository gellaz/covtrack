import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/settings.dart';
import '../../services/settings/settings_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService settingsService;

  SettingsBloc({@required this.settingsService})
      : assert(settingsService != null);

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is ChangeSettings) {
      yield* _mapChangeSettingsToState(event.newSettings);
    }
  }

  Stream<SettingsState> _mapAppStartedToState() async* {
    yield SettingsLoading();
    final firstRun = await settingsService.isFirstRun();
    if (firstRun) {
      final createdSettings = await settingsService.initSettings();
      yield SettingsCreated(createdSettings);
    } else {
      final loadedSettings = await settingsService.loadSettings();
      yield SettingsLoaded(loadedSettings);
    }
  }

  Stream<SettingsState> _mapChangeSettingsToState(
    Map<String, dynamic> newSettings,
  ) async* {
    await settingsService.saveSettings(newSettings);
    final settings = Settings();
    settings.updateFromMap(settingsMap: newSettings);
    yield SettingsChanged(settings);
  }
}

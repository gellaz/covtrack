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
      yield* _mapAppLoadedToState();
    } else if (event is SettingsChanged) {
      yield* _mapSettingsChangedToState(event.newSettings);
    }
  }

  Stream<SettingsState> _mapAppLoadedToState() async* {
    yield SettingsLoadInProgress();
    try {
      final settings = await settingsRepository.getSettings();
      print('settingz: $settings');
      if (settings == null) {
        settingsRepository.insert(
          Settings(
            settingsId: 'covtrackSettings',
            firstRun: true,
            theme: 'light',
          ),
        );
      }

      yield SettingsLoadSuccess(settings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }

  Stream<SettingsState> _mapSettingsChangedToState(
    Settings newSettings,
  ) async* {
    yield SettingsLoadInProgress();
    try {
      await settingsRepository.update(newSettings);
      yield SettingsLoadSuccess(newSettings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covtrack/repositories/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsBloc({@required this.settingsRepository})
      : assert(settingsRepository != null);

  @override
  SettingsState get initialState => SettingsLoading();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is AppLaunched) {
      yield* _mapAppLaunchedToState();
    } else if (event is ChangedTheme) {
      yield* _mapChangedThemeToState(event.lightTheme);
    }
  }

  Stream<SettingsState> _mapAppLaunchedToState() async* {
    final settings = await settingsRepository.loadSettings();
    print('ciao');
    yield SettingsLoaded.fromMap(settings);
  }

  Stream<SettingsState> _mapChangedThemeToState(bool lightTheme) async* {
    await settingsRepository.setTheme(lightTheme);
    yield NewSettings.fromOldSettingState(state, isLightTheme: lightTheme);
  }
}

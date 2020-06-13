import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../repositories/settings/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

/// BLoC responsible for the business logic behind the settings section of the app by
/// loading the settings from a local database. In particular this BLoC will map the
/// incoming [SettingsEvent] to the correct [SettingsState].
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  // Settings repository used to manage the CRUD operations with the database.
  final SettingsRepository settingsRepository;

  SettingsBloc({@required this.settingsRepository})
      : assert(settingsRepository != null);

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    yield SettingsLoadInProgress();
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState();
    } else if (event is SettingChanged) {
      yield* _mapSettingsChangedToState(event);
    }
  }

  Stream<SettingsState> _mapAppLoadedToState() async* {
    try {
      final settings = await settingsRepository.getSettings();
      yield SettingsLoadSuccess(settings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }

  Stream<SettingsState> _mapSettingsChangedToState(
    SettingChanged event,
  ) async* {
    try {
      await settingsRepository.saveKV(event.key, event.value);
      final settings = await settingsRepository.getSettings();
      yield SettingsLoadSuccess(settings);
    } catch (e) {
      yield SettingsLoadFailure(e.toString());
    }
  }
}

part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class AppLoaded extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SettingsChanged extends SettingsEvent {
  final Settings newSettings;

  const SettingsChanged(this.newSettings);

  @override
  List<Object> get props => [newSettings];

  @override
  String toString() => 'SettingsChanged {newSettings: $newSettings}';
}

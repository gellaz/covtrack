part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class AppLoaded extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class ChangeSettings extends SettingsEvent {
  final Map<String, dynamic> newSettings;

  const ChangeSettings(this.newSettings);

  @override
  List<Object> get props => [newSettings];
}

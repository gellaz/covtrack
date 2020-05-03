part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
  @override
  List<Object> get props => [];
}

class SettingsCreated extends SettingsState {
  final Settings settings;
  const SettingsCreated(this.settings);
  @override
  List<Object> get props => [settings];
}

class SettingsLoaded extends SettingsState {
  final Settings settings;
  const SettingsLoaded(this.settings);
  @override
  List<Object> get props => [settings];
}

class SettingsChanged extends SettingsState {
  final Settings newSettings;
  const SettingsChanged(this.newSettings);
  @override
  List<Object> get props => [newSettings];
}

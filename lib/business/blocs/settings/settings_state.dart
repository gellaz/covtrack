part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoadInProgress extends SettingsState {}

class SettingsLoadSuccess extends SettingsState {
  final Map<String, dynamic> settings;

  const SettingsLoadSuccess(this.settings);

  @override
  List<Object> get props => [settings];

  @override
  String toString() => 'SettingsLoadSuccess { settings: $settings }';
}

class SettingsLoadFailure extends SettingsState {
  final String message;

  const SettingsLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SettingsLoadFailure { message: $message }';
}

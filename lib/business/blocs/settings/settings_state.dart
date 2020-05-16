part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SettingsInitial';
}

class SettingsLoadInProgress extends SettingsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SettingsLoadInProgress';
}

class SettingsLoadSuccess extends SettingsState {
  final Settings settings;

  const SettingsLoadSuccess(this.settings);

  @override
  List<Object> get props => [settings];

  @override
  String toString() => 'SettingsLoadSuccess {settings: $settings}';
}

class SettingsLoadFailure extends SettingsState {
  final String message;

  const SettingsLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SettingsLoadFailure {message: $message}';
}

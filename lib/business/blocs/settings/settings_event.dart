part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class AppLoaded extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SettingChanged extends SettingsEvent {
  final String key;
  final dynamic value;

  const SettingChanged(this.key, this.value);

  @override
  List<Object> get props => [key, value];

  @override
  String toString() => 'SettingChanged {key: $key, value: $value}';
}

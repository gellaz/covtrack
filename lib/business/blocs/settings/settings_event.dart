part of 'settings_bloc.dart';

/// The [SettingsBloc] will need to know how to process the following events:
/// [AppLoaded] - informs the [SettingsBloc] that the application should load all the settings necessary to be launched.
/// [SettingChanged] - informs the [SettingsBloc] that a setting has been changed.
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends SettingsEvent {}

class SettingChanged extends SettingsEvent {
  final String key;
  final dynamic value;

  const SettingChanged({
    @required this.key,
    @required this.value,
  });

  @override
  List<Object> get props => [key, value];

  @override
  String toString() => 'SettingChanged { key: $key, value: $value }';
}

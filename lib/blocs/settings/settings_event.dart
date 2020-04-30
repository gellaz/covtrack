part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class AppLaunched extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class ChangedTheme extends SettingsEvent {
  final bool lightTheme;

  const ChangedTheme(this.lightTheme);

  @override
  List<Object> get props => [lightTheme];

  @override
  String toString() => 'ChangedTheme { lightTheme: $lightTheme }';
}

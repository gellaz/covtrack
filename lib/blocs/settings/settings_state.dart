part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  final bool isFirstLaunch;
  final bool isLightTheme;

  SettingsState({
    @required this.isFirstLaunch,
    @required this.isLightTheme,
  });
}

class SettingsLoading extends SettingsState {
  @override
  String toString() => 'SettingsLoading';
}

class SettingsLoaded extends SettingsState {
  SettingsLoaded.fromMap(Map<String, dynamic> map)
      : super(
          isFirstLaunch: map['firstLaunch'],
          isLightTheme: map['lightTheme'],
        );

  @override
  String toString() => 'SettingsLoaded { $isFirstLaunch, $isLightTheme }';
}

class NewSettings extends SettingsState {
  NewSettings.fromOldSettingState(SettingsState oldSettings,
      {bool isFirstLaunch, bool isLightTheme})
      : super(
          isFirstLaunch: isFirstLaunch ?? oldSettings.isFirstLaunch,
          isLightTheme: isLightTheme ?? oldSettings.isLightTheme,
        );

  @override
  String toString() => 'NewSettings { $isFirstLaunch, $isLightTheme }';
}

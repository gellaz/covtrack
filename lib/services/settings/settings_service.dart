import 'package:covtrack/models/settings.dart';

abstract class SettingsService {
  Future<Settings> initSettings();
  Future<bool> isFirstRun();
  Future<Settings> loadSettings();
  Future<void> saveSettings(Map<String, dynamic> newSettings);
}

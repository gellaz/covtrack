import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings.dart';

part 'sharedprefs_settings_service.dart';

abstract class SettingsService {
  Future<Settings> initSettings();
  Future<bool> isFirstRun();
  Future<Settings> loadSettings();
  Future<void> saveSettings(Map<String, dynamic> newSettings);
}

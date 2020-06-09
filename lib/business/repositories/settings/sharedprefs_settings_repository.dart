import 'package:shared_preferences/shared_preferences.dart';

import 'settings_repository.dart';

class SharedPrefsSettingsRepository implements SettingsRepository {
  @override
  Future<Map<String, dynamic>> getSettings() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    final firstRun = sharedPrefs.getBool('firstRun') ?? true;

    if (firstRun) await init();

    final keys = sharedPrefs.getKeys();

    Map<String, dynamic> settings = Map();

    for (var key in keys) settings[key] = sharedPrefs.get(key);

    return settings;
  }

  @override
  Future<void> init() async {
    await saveKV('firstRun', true);
    await saveKV('theme', 'light');
  }

  @override
  Future<void> saveKV(String key, dynamic value) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }
}

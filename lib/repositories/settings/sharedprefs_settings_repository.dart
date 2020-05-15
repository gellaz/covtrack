part of 'settings_repository.dart';

class SharedPrefsSettingsRepository implements SettingsRepository {
  @override
  Future<bool> isFirstRun() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('firstRun') ?? true;
  }

  @override
  Future<Settings> initSettings() async {
    final settings = Settings();
    await saveSettings(settings.toMap());
    return settings;
  }

  @override
  Future<Settings> loadSettings() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final settings = Settings();

    Map<String, dynamic> settingsMap = {};
    for (var key in sharedPrefs.getKeys()) {
      settingsMap[key] = sharedPrefs.get(key);
    }
    settings.updateFromMap(settingsMap: settingsMap);
    return settings;
  }

  @override
  Future<void> saveSettings(Map<String, dynamic> newSettings) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    newSettings.forEach((key, value) {
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
    });
  }
}

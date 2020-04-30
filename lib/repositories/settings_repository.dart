import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final Map<String, dynamic> initialSettings = {
    'firstLaunch': true,
    'lightTheme': true,
  };

  // Loads all the settings cached in local storage.
  Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // If it's the first time the app is launche, I initialize
    // the local storage and then I return a map containing the
    // initial settings.
    bool firstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (firstLaunch) {
      await prefs.setBool('firstLaunch', false);
      await prefs.setBool('lightTheme', true);

      return initialSettings;
    }

    // If it's not the first launch of the app, I load all the
    // saved settings and I return a map containing them.
    final Map<String, dynamic> map = {};
    final Set<String> keys = prefs.getKeys();

    for (var key in keys) {
      map[key] = prefs.get(key);
    }
    return map;
  }

  // Change the app color theme.
  Future<void> setTheme(bool lightTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lightTheme', lightTheme);
  }
}

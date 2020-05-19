abstract class SettingsRepository {
  Future<void> init();
  Future<void> saveKV(String key, dynamic value);
  Future<Map<String, dynamic>> getSettings();
}

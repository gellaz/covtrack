import 'package:covtrack/data/models/settings.dart';

abstract class SettingsRepository {
  Future<void> update(Settings settings);
  Future<Settings> getSettings();
}

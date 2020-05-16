import '../../../data/models/settings.dart';
import '../../providers/database_provider.dart';

abstract class SettingsRepository {
  DatabaseProvider databaseProvider;

  Future<Settings> insert(Settings settings);
  Future<Settings> update(Settings settings);
  Future<Settings> getSettings();
}

import '../../../data/daos/settings_dao.dart';
import '../../../data/models/settings.dart';
import '../../providers/database_provider.dart';
import 'settings_repository.dart';

class SettingsDatabaseRepository implements SettingsRepository {
  final dao = SettingsDao();

  @override
  DatabaseProvider databaseProvider;

  SettingsDatabaseRepository(this.databaseProvider)
      : assert(databaseProvider != null);

  @override
  Future<Settings> insert(Settings settings) async {
    final db = await databaseProvider.database;
    await db.insert(dao.tableName, dao.toMap(settings));
    return settings;
  }

  @override
  Future<Settings> getSettings() async {
    final db = await databaseProvider.database;
    List<Map> maps = await db.query(dao.tableName);
    if (maps.isNotEmpty) {
      return dao.fromList(maps).first;
    }
    return null;
  }

  @override
  Future<Settings> update(Settings settings) async {
    final db = await databaseProvider.database;
    await db.update(
      dao.tableName,
      dao.toMap(settings),
      where: dao.columnSettingsId + ' = ?',
      whereArgs: [settings.settingsId],
    );
    return settings;
  }
}

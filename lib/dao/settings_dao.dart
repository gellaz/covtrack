import '../models/settings.dart';
import 'dao.dart';

class SettingsDao implements Dao<Settings> {
  final tableName = 'settings';
  final columnSettingsId = 'settingsId';
  final columnFirstRun = 'firstRun';
  final columnTheme = 'theme';

  @override
  String get createTableQuery {
    return '''
    CREATE TABLE $tableName (
      $columnSettingsId TEXT PRIMARY KEY,
      $columnFirstRun INTEGER NOT NULL,
      $columnTheme TEXT NOT NULL
    )''';
  }

  @override
  List<Settings> fromList(List<Map<String, dynamic>> mapsList) {
    return mapsList.map((map) => fromMap(map)).toList();
  }

  @override
  Settings fromMap(Map<String, dynamic> map) {
    return Settings(
      settingsId: map[columnSettingsId],
      firstRun: map[columnFirstRun] == 1,
      theme: map[columnTheme],
    );
  }

  @override
  Map<String, dynamic> toMap(Settings settings) {
    return {
      columnSettingsId: settings.settingsId,
      columnFirstRun: settings.firstRun ? 1 : 0,
      columnTheme: settings.theme,
    };
  }
}

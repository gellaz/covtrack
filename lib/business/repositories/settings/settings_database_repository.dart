import 'package:covtrack/data/app_database.dart';
import 'package:sembast/sembast.dart';

import '../../../data/models/settings.dart';
import 'settings_repository.dart';

class SettingsDatabaseRepository implements SettingsRepository {
  // The name of the store.
  static const String SETTINGS_STORE_NAME = 'settings';

  // This store acts like a persistent map, values of which are Settings objects
  // converted to Map.
  final _settingsStore = intMapStoreFactory.store(SETTINGS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the singleton
  // instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<void> _init() async {
    await _settingsStore.add(await _db, Settings.init().toMap());
  }

  @override
  Future<void> update(Settings settings) async {
    final finder = Finder(filter: Filter.byKey(settings.settingsId));
    await _settingsStore.update(
      await _db,
      settings.toMap(),
      finder: finder,
    );
  }

  @override
  Future<Settings> getSettings() async {
    var recordSnapshots = await _settingsStore.find(await _db);
    if (recordSnapshots.isEmpty) {
      _init();
      recordSnapshots = await _settingsStore.find(await _db);
    }

    final settingsList = recordSnapshots.map((snapshot) {
      final settings = Settings.fromMap(snapshot.value);
      settings.copyWith(settingsId: snapshot.key);
      return settings;
    }).toList();
    return settingsList.first;
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/daos/place_dao.dart';
import '../../data/daos/settings_dao.dart';

class DatabaseProvider {
  static final _databaseName = 'covtrack.db';
  static final _databaseVersion = 1;

  // Private constructor to make this a singleton class.
  DatabaseProvider._internal();
  static final DatabaseProvider instance = DatabaseProvider._internal();

  // Single app-wide reference to the database.
  static Database _database;

  // Returns the instance of the database if already created
  // or initializes it if it is the first time it is accessed.
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _init();
    return _database;
  }

  // Opens the database and creates it if it does not exist.
  Future<Database> _init() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Executes the SQL queries to create the tables.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(PlaceDao().createTableQuery);
    await db.execute(SettingsDao().createTableQuery);
  }
}

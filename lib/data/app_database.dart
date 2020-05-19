import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // Name of the database.
  static final String _dbName = 'covtrack.db';

  // Singleton instance.
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton getter.
  static AppDatabase get instance => _singleton;

  // Transforms synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // Private constructor.
  AppDatabase._();

  // Database object getter.
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened.
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future<void> _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored.
    final appDocumentDir = await getApplicationDocumentsDirectory();

    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, _dbName);

    final database = await databaseFactoryIo.openDatabase(dbPath);

    // Any code awaiting the Completer's future will now start executing.
    _dbOpenCompleter.complete(database);
  }
}

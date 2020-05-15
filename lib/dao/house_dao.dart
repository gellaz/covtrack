import '../models/house.dart';
import 'dao.dart';

class HouseDao implements Dao<House> {
  final tableName = 'houses';
  final columnPlaceId = 'placeId';
  final columnLatitude = 'latitude';
  final columnLongitude = 'longitude';
  final columnFormattedAddress = 'formattedAddress';
  final columnName = 'name';
  final columnCurrent = 'current';

  @override
  String get createTableQuery {
    return '''
    CREATE TABLE $tableName (
      $columnPlaceId TEXT PRIMARY KEY,
      $columnLatitude REAL NOT NULL,
      $columnLongitude REAL NOT NULL,
      $columnFormattedAddress TEXT NOT NULL,
      $columnName TEXT NOT NULL,
      $columnCurrent INTEGER NOT NULL
    )''';
  }

  @override
  List<House> fromList(List<Map<String, dynamic>> mapsList) {
    return mapsList.map((map) => fromMap(map)).toList();
  }

  @override
  House fromMap(Map<String, dynamic> map) {
    return House(
      placeId: map[columnPlaceId],
      latitude: map[columnLatitude],
      longitude: map[columnLongitude],
      formattedAddress: map[columnFormattedAddress],
      name: map[columnName],
      current: map[columnCurrent] == 1,
    );
  }

  @override
  Map<String, dynamic> toMap(House house) {
    return {
      columnPlaceId: house.placeId,
      columnLatitude: house.latitude,
      columnLongitude: house.longitude,
      columnFormattedAddress: house.formattedAddress,
      columnName: house.name,
      columnCurrent: house.current ? 1 : 0,
    };
  }
}

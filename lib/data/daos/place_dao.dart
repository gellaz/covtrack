import '../models/place.dart';
import 'dao.dart';

class PlaceDao implements Dao<Place> {
  final tableName = 'places';
  final columnPlaceId = 'placeId';
  final columnLatitude = 'latitude';
  final columnLongitude = 'longitude';
  final columnFormattedAddress = 'formattedAddress';
  final columnName = 'name';

  @override
  String get createTableQuery {
    return '''
    CREATE TABLE $tableName (
      $columnPlaceId TEXT PRIMARY KEY,
      $columnLatitude REAL NOT NULL,
      $columnLongitude REAL NOT NULL,
      $columnFormattedAddress TEXT NOT NULL,
      $columnName TEXT NOT NULL
    )''';
  }

  @override
  List<Place> fromList(List<Map<String, dynamic>> mapsList) {
    return mapsList.map((map) => fromMap(map)).toList();
  }

  @override
  Place fromMap(Map<String, dynamic> map) {
    return Place(
      placeId: map[columnPlaceId],
      latitude: map[columnLatitude],
      longitude: map[columnLongitude],
      formattedAddress: map[columnFormattedAddress],
      name: map[columnName],
    );
  }

  @override
  Map<String, dynamic> toMap(Place place) {
    return {
      columnPlaceId: place.placeId,
      columnLatitude: place.latitude,
      columnLongitude: place.longitude,
      columnFormattedAddress: place.formattedAddress,
      columnName: place.name,
    };
  }
}

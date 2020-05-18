import '../models/trip.dart';
import 'dao.dart';
import 'place_dao.dart';

class TripDao implements Dao<Trip> {
  final tableName = 'trips';
  final columnTripId = 'tripId';
  final columnReason = 'reason';
  final columnStartingTime = 'startingTime';
  final columnArrivalTime = 'arrivalTime';
  final columnSourceId = 'sourceId';
  final columnDestinationId = 'destinationId';
  final placeDao = PlaceDao();

  @override
  String get createTableQuery {
    return '''
    CREATE TABLE $tableName (
      $columnTripId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnReason TEXT NOT NULL,
      $columnStartingTime INTEGER NOT NULL,
      $columnArrivalTime INTEGER NOT NULL,
      $columnSourceId INTEGER NOT NULL,
      $columnDestinationId INTEGER NOT NULL
    )''';
  }

  @override
  List<Trip> fromList(List<Map<String, dynamic>> mapsList) {
    // TODO: implement fromList
    throw UnimplementedError();
  }

  @override
  Trip fromMap(Map<String, dynamic> map) {
    return Trip(
      tripId: map[columnTripId],
      reason: map[columnReason],
      startingTime: null,
      arrivalTime: null,
      source: placeDao.fromMap(map),
      destination: null,
    );
  }

  @override
  Map<String, dynamic> toMap(Trip trip) {
    return {
      columnTripId: trip.tripId,
      columnReason: trip.reason,
      columnStartingTime: null,
      columnArrivalTime: null,
      columnSourceId: trip.source.placeId,
      columnDestinationId: trip.destination.placeId,
    };
  }
}

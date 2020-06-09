import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../../../data/coordinates.dart';
import '../../../data/stop.dart';
import 'location_repository.dart';

/// Implementation of the [LocationRepository] interface that uses the [geolocator] package
/// to retrieve location data from the device and manage the relative permissions.
class GeolocatorLocationRepository implements LocationRepository {
  final Geolocator _geolocator = Geolocator();

  @override
  Future<Coordinates> get currentLocation async {
    Position position = await _geolocator.getCurrentPosition();
    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Stream<Stop> get locationStream async* {
    LocationOptions options = LocationOptions(
      accuracy: LocationAccuracy.best,
      distanceFilter: 10,
      timeInterval: 0,
    );
    yield* _geolocator.getPositionStream(options).map((Position pos) {
      return Stop(
        coords: Coordinates(
          latitude: pos.latitude,
          longitude: pos.longitude,
        ),
        time: DateTime.now(),
      );
    });
  }
}

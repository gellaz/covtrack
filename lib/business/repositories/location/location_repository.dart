import 'dart:async';

import '../../../data/coordinates.dart';
import '../../../data/stop.dart';

/// Contract that all the implementations of the [LocationRepository] interface must follow.
abstract class LocationRepository {
  /// Returns the current location of the device in terms of latitude and longitude coordinates.
  Future<Coordinates> get currentLocation;

  /// Returns a stream of [Stop] objects. In this way is possible to listen for continuous
  /// stops updates.
  Stream<Stop> get locationStream;
}

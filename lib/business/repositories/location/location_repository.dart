import 'dart:async';

import '../../../data/coordinates.dart';
import '../../../data/stop.dart';

/// Contract that all the implementations of the interface must follow.
abstract class LocationRepository {
  /// Returns map containing the current location of the user in terms of coordinates
  /// (latitude and longitude).
  ///
  /// Example:
  /// {
  ///   'latitude': 144.777730,
  ///   'longitude: -11.342257,
  /// }
  Future<Coordinates> get currentLocation;
  Stream<Stop> get locationStream;
}

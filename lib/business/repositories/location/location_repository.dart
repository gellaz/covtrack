import 'dart:async';

import '../../../data/coordinates.dart';
import '../../../data/stop.dart';

/// Contract that all the implementations of the [LocationRepository] interface must follow.
abstract class LocationRepository {
  Future<Coordinates> get currentLocation;
  Stream<Stop> get locationStream;
}

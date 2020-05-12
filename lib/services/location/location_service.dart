import 'package:geolocator/geolocator.dart';

import '../../models/coordinates.dart';

part 'geolocator_location_service.dart';

/// Contract that all the implementations of the interface must follow.
abstract class LocationService {
  /// Return the current location of the user in terms of coordinates
  /// (latitude and longitude).
  Future<Coordinates> getCurrentLocation();
}

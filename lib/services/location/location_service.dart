import 'package:geolocator/geolocator.dart';

import '../../models/place.dart';

part 'geolocator_location_service.dart';

abstract class LocationService {
  Future<Place> getCurrentLocation();
}

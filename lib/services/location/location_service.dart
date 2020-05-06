import 'package:covtrack/models/place.dart';

abstract class LocationService {
  Future<Place> getCurrentLocation();
}

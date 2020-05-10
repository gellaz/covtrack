import 'package:geolocator/geolocator.dart';

part 'geolocator_location_service.dart';

abstract class LocationService {
  Future<Position> getCurrentPosition();
}

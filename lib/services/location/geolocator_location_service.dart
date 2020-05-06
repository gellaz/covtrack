import 'package:covtrack/models/place.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class GeolocatorLocationService implements LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  Future<Place> getCurrentLocation() async {
    final currentLocation = await geolocator.getCurrentPosition();
    return Place(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
  }
}

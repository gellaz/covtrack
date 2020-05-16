import 'package:geolocator/geolocator.dart';

import 'location_repository.dart';

/// Implementation of the [LocationRepository] interface that uses
/// the package [geolocator] to retrieve location data from the
/// device and manage the relative permissions.
class GeolocatorLocationRepository implements LocationRepository {
  final Geolocator geolocator = Geolocator();

  @override
  Future<Map<String, double>> getCurrentLocation() async {
    final position = await geolocator.getCurrentPosition();
    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}

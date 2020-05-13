part of 'location_service.dart';

/// Implementation of the [LocationService] interface that uses
/// the package [geolocator] to retrieve location data from the
/// device and manage the relative permissions.
class GeolocatorLocationService implements LocationService {
  final Geolocator geolocator = Geolocator();

  @override
  Future<Position> getCurrentLocation() async {
    return await geolocator.getCurrentPosition();
  }
}

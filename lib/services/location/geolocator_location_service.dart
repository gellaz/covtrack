part of 'location_service.dart';

/// Implementation of the [LocationService] interface that uses
/// the package [geolocator] to retrieve location data from the
/// device and manage the relative permissions.
class GeolocatorLocationService implements LocationService {
  final Geolocator geolocator = Geolocator();

  @override
  Future<Coordinates> getCurrentLocation() async {
    final position = await geolocator.getCurrentPosition();
    return Coordinates(position.latitude, position.longitude);
  }
}

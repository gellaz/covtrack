part of 'location_service.dart';

class GeolocatorLocationService implements LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  Future<Place> getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }
}

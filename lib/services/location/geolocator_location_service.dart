part of 'location_service.dart';

class GeolocatorLocationService implements LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  Future<Position> getCurrentPosition() async {
    return await geolocator.getCurrentPosition();
  }
}
